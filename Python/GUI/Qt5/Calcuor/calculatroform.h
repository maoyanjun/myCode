#ifndef CALCULATROFORM_H
#define CALCULATROFORM_H

#include <QMainWindow>

namespace Ui {
class calculatroform;
}

class calculatroform : public QMainWindow
{
    Q_OBJECT

public:
    explicit calculatroform(QWidget *parent = 0);
    ~calculatroform();

private:
    Ui::calculatroform *ui;
};

#endif // CALCULATROFORM_H
