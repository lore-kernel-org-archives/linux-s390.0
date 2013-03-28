From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 28 Mar 2013 04:02:41 +0000
Subject: drivers/mfd/pm8xxx-irq.c:131:4: error: implicit declaration of function 'generic_handle_irq'
Message-Id: <20130328040241.GA22186@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Hi Abhijeet,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
commit: c013f0a56c56b88ac63c4037f2dfaaf2422fa863 mfd: Add pm8xxx irq support
date:   1 year, 10 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_block_handler':
>> drivers/mfd/pm8xxx-irq.c:131:4: error: implicit declaration of function 'generic_handle_irq' [-Werror=implicit-function-declaration]
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:160:57: warning: 'struct irq_desc' declared inside parameter list [enabled by default]
   drivers/mfd/pm8xxx-irq.c:160:57: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_handler':
>> drivers/mfd/pm8xxx-irq.c:162:9: error: implicit declaration of function 'irq_desc_get_handler_data' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:162:29: warning: initialization makes pointer from integer without a cast [enabled by default]
>> drivers/mfd/pm8xxx-irq.c:163:9: error: implicit declaration of function 'irq_desc_get_chip' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:163:30: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/mfd/pm8xxx-irq.c:181:10: error: dereferencing pointer to incomplete type
   drivers/mfd/pm8xxx-irq.c:181:25: error: dereferencing pointer to incomplete type
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:184:40: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_mask_ack':
>> drivers/mfd/pm8xxx-irq.c:186:9: error: implicit declaration of function 'irq_data_get_irq_chip_data' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:186:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/mfd/pm8xxx-irq.c:187:24: error: dereferencing pointer to incomplete type
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:199:38: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_unmask':
>> drivers/mfd/pm8xxx-irq.c:201:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/mfd/pm8xxx-irq.c:202:24: error: dereferencing pointer to incomplete type
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:214:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_set_type':
>> drivers/mfd/pm8xxx-irq.c:216:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/mfd/pm8xxx-irq.c:217:24: error: dereferencing pointer to incomplete type
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:245:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/mfd/pm8xxx-irq.c:250:15: error: variable 'pm8xxx_irq_chip' has initializer but incomplete type
   drivers/mfd/pm8xxx-irq.c:251:2: error: unknown field 'name' specified in initializer
   drivers/mfd/pm8xxx-irq.c:251:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:251:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:252:2: error: unknown field 'irq_mask_ack' specified in initializer
   drivers/mfd/pm8xxx-irq.c:252:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:252:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:253:2: error: unknown field 'irq_unmask' specified in initializer
   drivers/mfd/pm8xxx-irq.c:253:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:253:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:254:2: error: unknown field 'irq_set_type' specified in initializer
   drivers/mfd/pm8xxx-irq.c:254:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:254:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:255:2: error: unknown field 'irq_set_wake' specified in initializer
   drivers/mfd/pm8xxx-irq.c:255:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:255:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:256:2: error: unknown field 'flags' specified in initializer
   drivers/mfd/pm8xxx-irq.c:256:12: error: 'IRQCHIP_MASK_ON_SUSPEND' undeclared here (not in a function)
   drivers/mfd/pm8xxx-irq.c:256:2: warning: excess elements in struct initializer [enabled by default]
   drivers/mfd/pm8xxx-irq.c:256:2: warning: (near initialization for 'pm8xxx_irq_chip') [enabled by default]
   drivers/mfd/pm8xxx-irq.c:272:5: error: redefinition of 'pm8xxx_get_irq_stat'
   include/linux/mfd/pm8xxx/irq.h:44:19: note: previous definition of 'pm8xxx_get_irq_stat' was here
   drivers/mfd/pm8xxx-irq.c:312:33: error: conflicting types for 'pm8xxx_irq_init'
   include/linux/mfd/pm8xxx/irq.h:48:46: note: previous definition of 'pm8xxx_irq_init' was here
   drivers/mfd/pm8xxx-irq.c: In function 'pm8xxx_irq_init':
>> drivers/mfd/pm8xxx-irq.c:347:3: error: implicit declaration of function 'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:349:5: error: 'handle_level_irq' undeclared (first use in this function)
   drivers/mfd/pm8xxx-irq.c:349:5: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/mfd/pm8xxx-irq.c:350:3: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:354:3: error: implicit declaration of function 'irq_set_noprobe' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:358:2: error: implicit declaration of function 'irq_set_irq_type' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:359:2: error: implicit declaration of function 'irq_set_handler_data' [-Werror=implicit-function-declaration]
>> drivers/mfd/pm8xxx-irq.c:360:2: error: implicit declaration of function 'irq_set_chained_handler' [-Werror=implicit-function-declaration]
   drivers/mfd/pm8xxx-irq.c:361:2: error: implicit declaration of function 'set_irq_wake' [-Werror=implicit-function-declaration]
   drivers/mfd/pm8xxx-irq.c: At top level:
   drivers/mfd/pm8xxx-irq.c:366:15: error: redefinition of 'pm8xxx_irq_exit'
   include/linux/mfd/pm8xxx/irq.h:54:29: note: previous definition of 'pm8xxx_irq_exit' was here
   cc1: some warnings being treated as errors

vim +/generic_handle_irq +131 drivers/mfd/pm8xxx-irq.c

c013f0a5 Abhijeet Dharmapurikar 2011-04-05  125  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  126  	/* Check IRQ bits */
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  127  	for (i = 0; i < 8; i++) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  128  		if (bits & (1 << i)) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  129  			pmirq = block * 8 + i;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  130  			irq = pmirq + chip->irq_base;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @131  			generic_handle_irq(irq);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  132  		}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  133  	}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  134  	return 0;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  135  }
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  136  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  137  static int pm8xxx_irq_master_handler(struct pm_irq_chip *chip, int master)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  138  {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  139  	u8 blockbits;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  140  	int block_number, i, ret = 0;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  141  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  142  	ret = pm8xxx_read_master_irq(chip, master, &blockbits);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  143  	if (ret) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  144  		pr_err("Failed to read master %d ret=%d\n", master, ret);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  145  		return ret;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  146  	}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  147  	if (!blockbits) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  148  		pr_err("master bit set in root but no blocks: %d", master);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  149  		return 0;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  150  	}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  151  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  152  	for (i = 0; i < 8; i++)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  153  		if (blockbits & (1 << i)) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  154  			block_number = master * 8 + i;	/* block # */
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  155  			ret |= pm8xxx_irq_block_handler(chip, block_number);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  156  		}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  157  	return ret;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  158  }
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  159  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  160  static void pm8xxx_irq_handler(unsigned int irq, struct irq_desc *desc)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  161  {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @162  	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @163  	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  164  	u8	root;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  165  	int	i, ret, masters = 0;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  166  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  167  	ret = pm8xxx_read_root_irq(chip, &root);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  168  	if (ret) {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  169  		pr_err("Can't read root status ret=%d\n", ret);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  170  		return;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  171  	}
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  172  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  173  	/* on pm8xxx series masters start from bit 1 of the root */
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  174  	masters = root >> 1;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  175  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  176  	/* Read allowed masters for blocks. */
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  177  	for (i = 0; i < chip->num_masters; i++)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  178  		if (masters & (1 << i))
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  179  			pm8xxx_irq_master_handler(chip, i);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  180  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  181  	irq_chip->irq_ack(&desc->irq_data);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  182  }
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  183  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  184  static void pm8xxx_irq_mask_ack(struct irq_data *d)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  185  {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @186  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  187  	unsigned int pmirq = d->irq - chip->irq_base;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  188  	int	master, irq_bit;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  189  	u8	block, config;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  190  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  191  	block = pmirq / 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  192  	master = block / 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  193  	irq_bit = pmirq % 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  194  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  195  	config = chip->config[pmirq] | PM_IRQF_MASK_ALL | PM_IRQF_CLR;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  196  	pm8xxx_config_irq(chip, block, config);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  197  }
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  198  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  199  static void pm8xxx_irq_unmask(struct irq_data *d)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  200  {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @201  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  202  	unsigned int pmirq = d->irq - chip->irq_base;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  203  	int	master, irq_bit;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  204  	u8	block, config;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  205  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  206  	block = pmirq / 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  207  	master = block / 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  208  	irq_bit = pmirq % 8;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  209  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  210  	config = chip->config[pmirq];
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  211  	pm8xxx_config_irq(chip, block, config);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  212  }
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  213  
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  214  static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  215  {
c013f0a5 Abhijeet Dharmapurikar 2011-04-05 @216  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  217  	unsigned int pmirq = d->irq - chip->irq_base;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  218  	int master, irq_bit;
c013f0a5 Abhijeet Dharmapurikar 2011-04-05  219  	u8 block, config;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
