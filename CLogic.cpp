// HEADER
#ifndef CLOGIC_H
#include "CLogic.h"
#endif // !CLOGIC_H

#ifdef QT_DEBUG // DEBUG
#include <exception>
#endif // DEBUG

// CONSTRUCTOR
CLogic::CLogic( QObject *const qParent ) noexcept
    : QObject ( qParent ),
    mStoredValue( "" ),
    mLeftArg{ },
    mRightArg( "" ),
    mOutput( "" ),
    mOperationType{ }
{ }

// DESTRUCTOR
CLogic::~CLogic( ) noexcept = default;

// GETTERS & SETTERS
QString CLogic::setOperationType( const QString pType ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::setOperationType" );
#endif // DEBUG

    if ( mRightArg.size( ) != 0 || ( mOutput.isEmpty() == false && mOutput.back() != ")" ) ) {
        // Set type
        if ( pType == "-" ) {
            mOperationType.push_back( QChar::fromLatin1( SUB_OPERATION_TYPE ) );
        } else if ( pType == "+" ) {
            mOperationType.push_back( QChar::fromLatin1( SUM_OPERATION_TYPE ) );
        } else if ( pType == "/" ) {
            mOperationType.push_back( QChar::fromLatin1( DIV_OPERATION_TYPE ) );
        } else if ( pType == "*" ) {
            mOperationType.push_back( QChar::fromLatin1( MUL_OPERATION_TYPE ) );
        }

        // Update Output
        onUpdateOutput( );
        // Return output
        return( mOutput );
    }

    // Cancel, if Argument is empty.
    if ( mRightArg.size( ) == 0 )
        if ( mOutput.size( ) == 0 )
            return "0";
        return( mOutput );

    return "0";
}

QString CLogic::getOutput( ) noexcept {
    onUpdateOutput();
    return( mOutput );
}

// PRIVATE METHODS
bool CLogic::isOperator(QChar character) noexcept {
    if (character == '+' || character == '-' || character == '*' || character == '/') {
        return true;
    }
    return false;
}

bool CLogic::isOperand(QChar character) noexcept {
    if (!isOperator(character) && character != '(' && character != ')') {
        return true;
    }
    return false;
}

void CLogic::onUpdateOutput( ) noexcept {

    // Switch Arguments
    mLeftArg.push_back( mRightArg );
    mRightArg = "";

    // One argument
    if ( mLeftArg.size( ) == 1 && mOperationType.size() == 0) {

        mOutput = mLeftArg[0];
    }

    // Several arguments
    if ( mOperationType.size() > 0 && mLeftArg.size() > 0 && ( mLeftArg.size() - mOperationType.size() ) < 2 ) {

        // Reset Output-string.
        mOutput = "";

        // Append Left Arguments and operation-symbols
        for ( int i{ 0 }; i < mOperationType.size(); i++ ) {
            mOutput += mLeftArg[ i ];

            // Append operation-symbol
            switch( mOperationType[ i ].unicode() ) {
            case DIV_OPERATION_TYPE: {
                mOutput += " / ";
                break;
            }
            case MUL_OPERATION_TYPE: {
                mOutput += " * ";
                break;
            }
            case SUB_OPERATION_TYPE: {
                mOutput += " - ";
                break;
            }
            default:
            case SUM_OPERATION_TYPE: {
                mOutput += " + ";
                break;
            }
            } // Append operation-symbol

        } // Append Left Arguments and operation-symbols

        // Append last Argument
        if ( ( mLeftArg.size() - mOperationType.size() ) == 1 ) {
            mOutput += mLeftArg.back();
        } // Append last Argument

    } // Several arguments

    // 0
    if ( mOutput == "-" ||  mOutput == "-0" )
        mOutput = "";
    if ( mRightArg == "-" ||  mOutput == "-0" )
        mRightArg = "";

}

void CLogic::onCalculationDone( ) noexcept {

    // Reset Left-Argument.
    mLeftArg.clear( );

    // Reset Right-Argument
    mOutput = mRightArg;

    // Reset Operation-Type.
    mOperationType.clear();

}

// PUBLIC METHODS

Q_INVOKABLE QString CLogic::onDot( ) noexcept {

    // 0
    if ( mRightArg.size( ) < 1 ) {

        // Set Right Argument
        mRightArg = "0.";

        // Update Output
        onUpdateOutput( );

        // Return Output
        return( mOutput );

    } /// 0

    // Cancel, if Right Argument already contains symbol.
    if ( mRightArg.contains( '.' ) )
        return( mOutput );

    // Append dot-symbol to Right-Argument.
    mRightArg += ".";

    // Update Output
    onUpdateOutput( );

    // Return Output
    return( mOutput );

}



QString CLogic::onKeyboardInput( const QString pValue ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onKeyboardInput" );
#endif // DEBUG

    // Filter Number Input
    if ( pValue == "0" || pValue == "1" || pValue == "2"
        || pValue == "3" || pValue == "4" || pValue == "5"
        || pValue == "6" || pValue == "7" || pValue == "8"
        || pValue == "9" )
        return( onNumberInput( pValue ) );

    // Return Output
    return( mOutput );

}

QString CLogic::onNumberInput( const QString pVal ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onNumberInput" );
#endif // DEBUG

    // Append
    if ( pVal == "0" && mRightArg == "0" )
        return( mRightArg );
    else if ( mRightArg == "0" )
        mRightArg.chop( 1 );
    mRightArg += pVal;

    // Return Output
    return( mRightArg );

}

QString CLogic::onPutBrackets( ) noexcept {

    // Cancel, if nothing to put in brackets
    if ( mRightArg.size( ) == 0 || mOperationType.size() == 0 )
        return( mOutput );

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onPutBrackets" );
#endif // DEBUG

    mLeftArg.back() = "( " + mLeftArg.back();
    mRightArg += " )";

    onUpdateOutput();

    // Return Output
    return( mOutput );

}

QString CLogic::onReverseSign( ) noexcept {

    // Cancel, if nothing to reverse
    if ( mRightArg.size( ) == 0 || mRightArg == "0")
        return( mOutput );

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onReverseSign" );
#endif // DEBUG

    // Reverse
    if (mRightArg[0] != "-")
        mRightArg = "-" + mRightArg;
    else
        mRightArg.remove(0, 1);

    // Update output
    onUpdateOutput( );

    // Return Output
    return( mOutput );

}

QString CLogic::onTakeProcent( ) noexcept {

    // Cancel, if nothing to take procent from
    if ( mRightArg.size( ) == 0 )
        return( mOutput );

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onTakeProcent" );
#endif // DEBUG

    // Procent
    // Convert Right-Argument to number.
    mRightArg.chop(1);
    const double arg1_d( mRightArg.toDouble( ) );

    const auto result_( arg1_d / 100.0 );

    // Set Output
    mRightArg = QString::number( result_ );

    // Update output
    onUpdateOutput( );

    // Return Output
    return( mOutput );

}

QString CLogic::countOneGroup( QString initialText ) noexcept {
    mOperationType.clear();
    bool isOpeningBracket = false;
    QString firstArgTmp{ "" };
    QString secondArgTmp{ "" };
    QString outputText{ initialText };
    int operationTypes{ 2 };
    while ( true ) {
        initialText = outputText;
        outputText = "";
        for ( int i{ 0 }; i < initialText.size(); i++ ) {
            if ( initialText[ i ] == ' ' ) { } else
            if ( initialText[ i ] == '(' ) {
                QString tmp;
                while ( initialText[ i ] != ')' ) {
                    i++;
                    tmp += initialText[ i ];
                }
                tmp.chop( 1 );
                if ( firstArgTmp == "" )
                    firstArgTmp = countOneGroup( tmp );
                else
                    secondArgTmp = countOneGroup( tmp );
            } else if ( isOperand( initialText[ i ] ) && mOperationType.size() == 0) { // первый аргумент
                firstArgTmp += initialText[ i ];
            } else if ( isOperand( initialText[ i ] ) && mOperationType.size() != 0 ) { // второй аргумент
                secondArgTmp += initialText[ i ];
            } else if ( isOperator( initialText[ i ] ) && mOperationType.size() == 0 ) { // оператор после первого аргумента
                switch( operationTypes ) {
                    case 2: { // умножить или делить
                        if ( initialText[ i ] == '*' ) {
                            mOperationType.push_back( QChar::fromLatin1( MUL_OPERATION_TYPE ) );
                        } else if ( initialText[ i ] == '/' ) {
                            mOperationType.push_back( QChar::fromLatin1( DIV_OPERATION_TYPE ) );
                        } else { // сложение или вычетание остается на следующий проход
                            outputText += firstArgTmp + initialText[ i ];
                            firstArgTmp = "";
                            mOperationType.clear();
                        }
                        break;
                    }
                    case 1: { // сложить или вычесть
                        if ( initialText[ i ] == '+' ) {
                            mOperationType.push_back( QChar::fromLatin1( SUM_OPERATION_TYPE ) );
                        } else if ( initialText[ i ] == '-' ) { // проверка на вычитание или отрицательное число
                            if ( isOpeningBracket ) { // число
                                firstArgTmp += initialText[ i ];
                                isOpeningBracket = false;
                            } else { // вычитание
                                mOperationType.push_back( QChar::fromLatin1( SUB_OPERATION_TYPE ) );
                            }
                        }
                        break;
                    }
                }
            }
            if ( secondArgTmp.size( ) != 0 && ( isOperator( initialText[ i ] ) || initialText[ i ] == initialText.back() ) ) { // оператор после второго аргумента
                switch( mOperationType[ 0 ].unicode() ) {
                case DIV_OPERATION_TYPE: {
                    firstArgTmp = QString::number( firstArgTmp.toDouble() / secondArgTmp.toDouble() );
                    secondArgTmp = "";
                    break;
                }
                case MUL_OPERATION_TYPE: {
                    firstArgTmp = QString::number( firstArgTmp.toDouble() * secondArgTmp.toDouble() );
                    secondArgTmp = "";
                    break;
                }
                case SUB_OPERATION_TYPE: {
                    firstArgTmp = QString::number( firstArgTmp.toDouble() - secondArgTmp.toDouble() );
                    secondArgTmp = "";
                    break;
                }
                default:
                case SUM_OPERATION_TYPE: {
                    firstArgTmp = QString::number( firstArgTmp.toDouble() + secondArgTmp.toDouble() );
                    secondArgTmp = "";
                    break;
                }
                }
                mOperationType.clear();
            }
        }
        outputText += firstArgTmp;
        firstArgTmp = "";
        operationTypes --;
        if (operationTypes == 0)
            break;
    }
    return outputText;
}

QString CLogic::doMath( ) noexcept {

    // Cancel, if no action required
    if ( mOperationType.size() == 0 )
        return( mRightArg );

    onUpdateOutput();

    mRightArg = countOneGroup( mOutput );

    onCalculationDone();

    return mRightArg;
}

void CLogic::resetLogic( ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::Reset" );
#endif // DEBUG

    // Reset Values
    mLeftArg.clear();
    mRightArg = "";
    mOutput = "";
    mOperationType.clear();

}
