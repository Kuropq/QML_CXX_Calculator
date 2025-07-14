// HEADER
#ifndef CLOGIC_H
#include "CLogic.h"
#endif // !CLOGIC_H

// Math
#include <QtMath>

#ifdef QT_DEBUG // DEBUG
#include <exception>
#endif // DEBUG

// CONSTRUCTOR
CLogic::CLogic( QObject *const qParent ) noexcept
    : QObject ( qParent ),
    mStoredValue( "" ),
    mLeftArg( "" ),
    mRightArg( "" ),
    mOutput( "0" ),
    mOperationType( NONE_OPERATION_TYPE )
{
}

// DESTRUCTOR
CLogic::~CLogic( ) noexcept = default;

// GETTERS & SETTERS
QString CLogic::setOperationType( const QString pType ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::setOperationType" );
#endif // DEBUG

    // Cancel, if Arguments are empty.
    if ( mLeftArg.size( ) < 1 && mRightArg.size( ) < 1 )
        return( mOutput );

    // Set type
    if ( pType == "-" )
        mOperationType = SUB_OPERATION_TYPE;
    else if ( pType == "+" )
        mOperationType = SUM_OPERATION_TYPE;
    else if ( pType == "/" )
        mOperationType = DIV_OPERATION_TYPE;
    else if ( pType == "*" )
        mOperationType = MUL_OPERATION_TYPE;

    // Switch Arguments
    mLeftArg = mRightArg; // Copy-Construct
    mRightArg = ""; // Clear/Reset

    // Update Output
    onUpdateOutput( );

    // Return output
    return( mOutput );

}

QString CLogic::getOutput( ) noexcept { return( mOutput ); }

// METHODS
/**
  * Updates Output-string.
  *
  * @thread_safety - not thread-safe.
  * @throws - no exceptions.
**/

void CLogic::onUpdateOutput( ) noexcept {

    // Reset Output-string.
    mOutput = "";

    // Left Argument
    if ( mLeftArg.size( ) > 0 )
        mOutput += mLeftArg;

    // Operation-Type
    if ( mOperationType != NONE_OPERATION_TYPE ) {

        // Append operation-symbol.
        switch( mOperationType ) {
            case DIV_OPERATION_TYPE: {
                mOutput += " / ";
                break;
            }
            case MUL_OPERATION_TYPE: {
                mOutput += " * ";
                break;
            }
            case SQRT_OPERATION_TYPE: {
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
        }

    } /// Operation-Type

    // Right Argument
    if ( mRightArg.size( ) > 0 )
        mOutput += mRightArg;

    // 0
    if ( mOutput.size( ) < 1 || mOutput == "-" )
        mOutput = "0";

}

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

void CLogic::onCalculationDone( ) noexcept {

    // Reset Left-Argument.
    mLeftArg.clear( );

    // Reset Right-Argument
    mRightArg = mOutput;

    // Reset Operation-Type.
    mOperationType = NONE_OPERATION_TYPE;

} /// CLogic::onCalculationDone

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

} /// CLogic::onKeyboardInput

QString CLogic::onNumberInput( const QString pVal ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onNumberInput" );
#endif // DEBUG

    // Append
    mRightArg += pVal;

    // Update output
    onUpdateOutput( );

    // Return Output
    return( mRightArg );

}

QString CLogic::onRemoveLastNumber( ) noexcept {

    // Cancel, if nothing to remove
    if ( mRightArg.size( ) == 0 )
        return( mOutput );

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::onRemoveLastNumber" );
#endif // DEBUG

    // Remove Last-symbol
    mRightArg.chop( 1 );

    // Update output
    mOutput.chop( 1 );
    onUpdateOutput( );

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

QString CLogic::doMath( ) noexcept {

    // Cancel, if no action required.
    if ( mOperationType == NONE_OPERATION_TYPE || mLeftArg.size( ) < 1 )
        return( mOutput );

    // Convert Left-Argument to number.
    const double arg1_d( mLeftArg.toDouble(  ) );

    // Convert Right-Argument to number.
    const double arg2_d( mRightArg.toDouble( ) );

    // Calculate
    switch( mOperationType ) {

        case SUB_OPERATION_TYPE: {

            // Sub
            const auto result_( arg1_d - arg2_d );

            // Set Output
            mOutput = QString::number( result_ );

            // Reset
            onCalculationDone( );

            // Stop
            break;

        }
        case MUL_OPERATION_TYPE: {

            // Mult
            const auto result_( arg1_d * arg2_d );

            // Set Output
            mOutput = QString::number( result_ );

            // Reset
            onCalculationDone( );

            // Stop
            break;

        }
        case DIV_OPERATION_TYPE: {

            // Div
            const auto result_( arg1_d / arg2_d );

            // Set Output
            mOutput = QString::number( result_ );

            // Reset
            onCalculationDone( );

            // Stop
            break;

        }
        case SUM_OPERATION_TYPE:
        default: {

            // Sum
            const auto result_( arg1_d + arg2_d );

            // Set Output
            mOutput = QString::number( result_ );

            // Reset
            onCalculationDone( );

            // Stop
            break;

        }
    } /// Calculate

    // Return Output
    return( mOutput );

}

void CLogic::resetMemory( ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::resetMemory" );
#endif // DEBUG

    // Reset Stored Value
    mStoredValue.clear( );

}

void CLogic::resetLogic( ) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug( "CLogic::Reset" );
#endif // DEBUG

    // Reset Values
    mLeftArg = "";
    mRightArg = "";
    mOutput = "0";
    mOperationType = NONE_OPERATION_TYPE;

}
