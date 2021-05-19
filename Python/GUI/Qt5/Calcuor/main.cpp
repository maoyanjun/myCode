#include "calculatroform.h"
#include "ui_calculatroform.h"

calculatroform::calculatroform(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::calculatroform)
{
    ui->setupUi(this);
}

calculatroform::~calculatroform()
{
    delete ui;
}
