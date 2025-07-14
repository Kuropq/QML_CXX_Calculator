#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "CLogic.h"

int main(int argc, char *argv[])
{    
    QGuiApplication app(argc, argv);

    // Register CalculatorLogic
    qmlRegisterType<CLogic>( "CLogic", 1, 0, "CLogic" );

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("SimplrCalculator", "Main");

    return app.exec();
}
