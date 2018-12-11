const dictionary& alphaControls = mesh.solverDict(alpha1.name());

label nAlphaCorr(readLabel(alphaControls.lookup("nAlphaCorr"))); //当前时间步内对相场进行循环求解?

label nAlphaSubCycles(readLabel(alphaControls.lookup("nAlphaSubCycles")));//代表alpha方程中子循环的数目  降低时间步长以保证解的稳定

bool MULESCorr(alphaControls.lookupOrDefault<Switch>("MULESCorr", false));//MULES修正 保证在任何数值格式、网格类型的情况下相场有界

// Apply the compression correction from the previous iteration //从上一迭代步应用压缩修正
// Improves efficiency for steady-simulations but can only be applied //提高稳定模拟的效率
// once the alpha field is reasonably steady, i.e. fully developed //只在相对稳定的alpha场中应用
bool alphaApplyPrevCorr
(
    alphaControls.lookupOrDefault<Switch>("alphaApplyPrevCorr", false)
);

// Isotropic compression coefficient
scalar icAlpha
(
    alphaControls.lookupOrDefault<scalar>("icAlpha", 0) //各向同性压缩因子
);
