From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:57:16 +0000
Subject: drivers/mfd/arizona-irq.c:68:2: error: implicit declaration of function 'irq_set_irq_wake'
Message-Id: <20130329025716.GD10831@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Greetings,

FYI, kernel build failed on s390 since

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: 966cdc96e15d113da80622bdddd63b461a7492f5 mfd: arizona: Interrupt support
date:   9 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   drivers/mfd/arizona-irq.c: In function 'arizona_map_irq':
   drivers/mfd/arizona-irq.c:33:2: error: implicit declaration of function 'regmap_irq_get_virq' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c: In function 'arizona_set_irq_wake':
>> drivers/mfd/arizona-irq.c:68:2: error: implicit declaration of function 'irq_set_irq_wake' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c: In function 'arizona_irq_thread':
>> drivers/mfd/arizona-irq.c:107:3: error: implicit declaration of function 'handle_nested_irq' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c:107:3: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c: At top level:
   drivers/mfd/arizona-irq.c:115:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/arizona-irq.c:115:39: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/mfd/arizona-irq.c:119:40: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/arizona-irq.c:123:15: error: variable 'arizona_irq_chip' has initializer but incomplete type
   drivers/mfd/arizona-irq.c:124:2: error: unknown field 'name' specified in initializer
   drivers/mfd/arizona-irq.c:124:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/arizona-irq.c:124:2: warning: (near initialization for 'arizona_irq_chip') [enabled by default]
   drivers/mfd/arizona-irq.c:125:2: error: unknown field 'irq_disable' specified in initializer
   drivers/mfd/arizona-irq.c:125:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/arizona-irq.c:125:2: warning: (near initialization for 'arizona_irq_chip') [enabled by default]
   drivers/mfd/arizona-irq.c:126:2: error: unknown field 'irq_enable' specified in initializer
   drivers/mfd/arizona-irq.c:126:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/arizona-irq.c:126:2: warning: (near initialization for 'arizona_irq_chip') [enabled by default]
   drivers/mfd/arizona-irq.c: In function 'arizona_irq_map':
>> drivers/mfd/arizona-irq.c:134:2: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
>> drivers/mfd/arizona-irq.c:135:2: error: implicit declaration of function 'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
>> drivers/mfd/arizona-irq.c:135:52: error: 'handle_edge_irq' undeclared (first use in this function)
   drivers/mfd/arizona-irq.c:135:52: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/mfd/arizona-irq.c:136:2: error: implicit declaration of function 'irq_set_nested_thread' [-Werror=implicit-function-declaration]
>> drivers/mfd/arizona-irq.c:143:2: error: implicit declaration of function 'irq_set_noprobe' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c: At top level:
   drivers/mfd/arizona-irq.c:151:11: error: 'irq_domain_xlate_twocell' undeclared here (not in a function)
   drivers/mfd/arizona-irq.c: In function 'arizona_irq_init':
   drivers/mfd/arizona-irq.c:185:2: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c:185:16: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/mfd/arizona-irq.c:192:2: error: implicit declaration of function 'regmap_add_irq_chip' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c:193:7: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
   drivers/mfd/arizona-irq.c:246:2: error: implicit declaration of function 'regmap_del_irq_chip' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/irq_set_irq_wake +68 drivers/mfd/arizona-irq.c

966cdc96 Mark Brown 2012-06-19   62  int arizona_set_irq_wake(struct arizona *arizona, int irq, int on)
966cdc96 Mark Brown 2012-06-19   63  {
966cdc96 Mark Brown 2012-06-19   64  	irq = arizona_map_irq(arizona, irq);
966cdc96 Mark Brown 2012-06-19   65  	if (irq < 0)
966cdc96 Mark Brown 2012-06-19   66  		return irq;
966cdc96 Mark Brown 2012-06-19   67  
966cdc96 Mark Brown 2012-06-19  @68  	return irq_set_irq_wake(irq, on);
966cdc96 Mark Brown 2012-06-19   69  }
966cdc96 Mark Brown 2012-06-19   70  EXPORT_SYMBOL_GPL(arizona_set_irq_wake);
966cdc96 Mark Brown 2012-06-19   71  
966cdc96 Mark Brown 2012-06-19   72  static irqreturn_t arizona_boot_done(int irq, void *data)
966cdc96 Mark Brown 2012-06-19   73  {
966cdc96 Mark Brown 2012-06-19   74  	struct arizona *arizona = data;
966cdc96 Mark Brown 2012-06-19   75  
966cdc96 Mark Brown 2012-06-19   76  	dev_dbg(arizona->dev, "Boot done\n");
966cdc96 Mark Brown 2012-06-19   77  
966cdc96 Mark Brown 2012-06-19   78  	return IRQ_HANDLED;
966cdc96 Mark Brown 2012-06-19   79  }
966cdc96 Mark Brown 2012-06-19   80  
966cdc96 Mark Brown 2012-06-19   81  static irqreturn_t arizona_ctrlif_err(int irq, void *data)
966cdc96 Mark Brown 2012-06-19   82  {
966cdc96 Mark Brown 2012-06-19   83  	struct arizona *arizona = data;
966cdc96 Mark Brown 2012-06-19   84  
966cdc96 Mark Brown 2012-06-19   85  	/*
966cdc96 Mark Brown 2012-06-19   86  	 * For pretty much all potential sources a register cache sync
966cdc96 Mark Brown 2012-06-19   87  	 * won't help, we've just got a software bug somewhere.
966cdc96 Mark Brown 2012-06-19   88  	 */
966cdc96 Mark Brown 2012-06-19   89  	dev_err(arizona->dev, "Control interface error\n");
966cdc96 Mark Brown 2012-06-19   90  
966cdc96 Mark Brown 2012-06-19   91  	return IRQ_HANDLED;
966cdc96 Mark Brown 2012-06-19   92  }
966cdc96 Mark Brown 2012-06-19   93  
966cdc96 Mark Brown 2012-06-19   94  static irqreturn_t arizona_irq_thread(int irq, void *data)
966cdc96 Mark Brown 2012-06-19   95  {
966cdc96 Mark Brown 2012-06-19   96  	struct arizona *arizona = data;
966cdc96 Mark Brown 2012-06-19   97  	int i, ret;
966cdc96 Mark Brown 2012-06-19   98  
966cdc96 Mark Brown 2012-06-19   99  	ret = pm_runtime_get_sync(arizona->dev);
966cdc96 Mark Brown 2012-06-19  100  	if (ret < 0) {
966cdc96 Mark Brown 2012-06-19  101  		dev_err(arizona->dev, "Failed to resume device: %d\n", ret);
966cdc96 Mark Brown 2012-06-19  102  		return IRQ_NONE;
966cdc96 Mark Brown 2012-06-19  103  	}
966cdc96 Mark Brown 2012-06-19  104  
966cdc96 Mark Brown 2012-06-19  105  	/* Check both domains */
966cdc96 Mark Brown 2012-06-19  106  	for (i = 0; i < 2; i++)
966cdc96 Mark Brown 2012-06-19 @107  		handle_nested_irq(irq_find_mapping(arizona->virq, i));
966cdc96 Mark Brown 2012-06-19  108  
966cdc96 Mark Brown 2012-06-19  109  	pm_runtime_mark_last_busy(arizona->dev);
966cdc96 Mark Brown 2012-06-19  110  	pm_runtime_put_autosuspend(arizona->dev);
966cdc96 Mark Brown 2012-06-19  111  
966cdc96 Mark Brown 2012-06-19  112  	return IRQ_HANDLED;
966cdc96 Mark Brown 2012-06-19  113  }
966cdc96 Mark Brown 2012-06-19  114  
966cdc96 Mark Brown 2012-06-19  115  static void arizona_irq_enable(struct irq_data *data)
966cdc96 Mark Brown 2012-06-19  116  {
966cdc96 Mark Brown 2012-06-19  117  }
966cdc96 Mark Brown 2012-06-19  118  
966cdc96 Mark Brown 2012-06-19  119  static void arizona_irq_disable(struct irq_data *data)
966cdc96 Mark Brown 2012-06-19  120  {
966cdc96 Mark Brown 2012-06-19  121  }
966cdc96 Mark Brown 2012-06-19  122  
966cdc96 Mark Brown 2012-06-19  123  static struct irq_chip arizona_irq_chip = {
966cdc96 Mark Brown 2012-06-19  124  	.name			= "arizona",
966cdc96 Mark Brown 2012-06-19  125  	.irq_disable		= arizona_irq_disable,
966cdc96 Mark Brown 2012-06-19  126  	.irq_enable		= arizona_irq_enable,
966cdc96 Mark Brown 2012-06-19  127  };
966cdc96 Mark Brown 2012-06-19  128  
966cdc96 Mark Brown 2012-06-19  129  static int arizona_irq_map(struct irq_domain *h, unsigned int virq,
966cdc96 Mark Brown 2012-06-19  130  			      irq_hw_number_t hw)
966cdc96 Mark Brown 2012-06-19  131  {
966cdc96 Mark Brown 2012-06-19  132  	struct regmap_irq_chip_data *data = h->host_data;
966cdc96 Mark Brown 2012-06-19  133  
966cdc96 Mark Brown 2012-06-19 @134  	irq_set_chip_data(virq, data);
966cdc96 Mark Brown 2012-06-19 @135  	irq_set_chip_and_handler(virq, &arizona_irq_chip, handle_edge_irq);
966cdc96 Mark Brown 2012-06-19 @136  	irq_set_nested_thread(virq, 1);
966cdc96 Mark Brown 2012-06-19  137  
966cdc96 Mark Brown 2012-06-19  138  	/* ARM needs us to explicitly flag the IRQ as valid
966cdc96 Mark Brown 2012-06-19  139  	 * and will set them noprobe when we do so. */
966cdc96 Mark Brown 2012-06-19  140  #ifdef CONFIG_ARM
966cdc96 Mark Brown 2012-06-19  141  	set_irq_flags(virq, IRQF_VALID);
966cdc96 Mark Brown 2012-06-19  142  #else
966cdc96 Mark Brown 2012-06-19 @143  	irq_set_noprobe(virq);
966cdc96 Mark Brown 2012-06-19  144  #endif
966cdc96 Mark Brown 2012-06-19  145  
966cdc96 Mark Brown 2012-06-19  146  	return 0;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
