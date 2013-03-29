From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:34:26 +0000
Subject: drivers/base/regmap/regmap-irq.c:44:9: error: implicit declaration of function 'irq_data_get_irq_chi
Message-Id: <20130329023426.GB9840@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Greetings,

These errors make me wonder if regmap is ever useable in s390..

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: f8beab2bb611d735767871e0e1a12dc6a0def7b1 regmap: Add a reusable irq_chip for regmap based interrupt controllers
date:   1 year, 5 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   drivers/base/regmap/regmap-irq.c:42:36: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c:42:36: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_lock':
>> drivers/base/regmap/regmap-irq.c:44:9: error: implicit declaration of function 'irq_data_get_irq_chip_data' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:44:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:49:43: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_sync_unlock':
   drivers/base/regmap/regmap-irq.c:51:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:70:38: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_enable':
   drivers/base/regmap/regmap-irq.c:72:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:73:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:78:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_disable':
   drivers/base/regmap/regmap-irq.c:80:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:81:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:86:15: error: variable 'regmap_irq_chip' has initializer but incomplete type
   drivers/base/regmap/regmap-irq.c:87:2: error: unknown field 'name' specified in initializer
   drivers/base/regmap/regmap-irq.c:87:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:87:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:88:2: error: unknown field 'irq_bus_lock' specified in initializer
   drivers/base/regmap/regmap-irq.c:88:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:88:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:89:2: error: unknown field 'irq_bus_sync_unlock' specified in initializer
   drivers/base/regmap/regmap-irq.c:89:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:89:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:90:2: error: unknown field 'irq_disable' specified in initializer
   drivers/base/regmap/regmap-irq.c:90:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:90:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:91:2: error: unknown field 'irq_enable' specified in initializer
   drivers/base/regmap/regmap-irq.c:91:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:91:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_thread':
>> drivers/base/regmap/regmap-irq.c:148:4: error: implicit declaration of function 'handle_nested_irq' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_add_irq_chip':
>> drivers/base/regmap/regmap-irq.c:178:2: error: implicit declaration of function 'irq_alloc_descs' [-Werror=implicit-function-declaration]
>> drivers/base/regmap/regmap-irq.c:233:3: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:234:3: error: implicit declaration of function 'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:235:7: error: 'handle_edge_irq' undeclared (first use in this function)
   drivers/base/regmap/regmap-irq.c:235:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/base/regmap/regmap-irq.c:236:3: error: implicit declaration of function 'irq_set_nested_thread' [-Werror=implicit-function-declaration]
>> drivers/base/regmap/regmap-irq.c:243:3: error: implicit declaration of function 'irq_set_noprobe' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/irq_data_get_irq_chip_data +44 drivers/base/regmap/regmap-irq.c

f8beab2b Mark Brown 2011-10-28   38  {
f8beab2b Mark Brown 2011-10-28   39  	return &data->chip->irqs[irq - data->irq_base];
f8beab2b Mark Brown 2011-10-28   40  }
f8beab2b Mark Brown 2011-10-28   41  
f8beab2b Mark Brown 2011-10-28   42  static void regmap_irq_lock(struct irq_data *data)
f8beab2b Mark Brown 2011-10-28   43  {
f8beab2b Mark Brown 2011-10-28  @44  	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
f8beab2b Mark Brown 2011-10-28   45  
f8beab2b Mark Brown 2011-10-28   46  	mutex_lock(&d->lock);
f8beab2b Mark Brown 2011-10-28   47  }
f8beab2b Mark Brown 2011-10-28   48  
f8beab2b Mark Brown 2011-10-28   49  static void regmap_irq_sync_unlock(struct irq_data *data)
f8beab2b Mark Brown 2011-10-28   50  {
f8beab2b Mark Brown 2011-10-28   51  	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
f8beab2b Mark Brown 2011-10-28   52  	int i, ret;
f8beab2b Mark Brown 2011-10-28   53  
f8beab2b Mark Brown 2011-10-28   54  	/*
f8beab2b Mark Brown 2011-10-28   55  	 * If there's been a change in the mask write it back to the
f8beab2b Mark Brown 2011-10-28   56  	 * hardware.  We rely on the use of the regmap core cache to
f8beab2b Mark Brown 2011-10-28   57  	 * suppress pointless writes.
f8beab2b Mark Brown 2011-10-28   58  	 */
f8beab2b Mark Brown 2011-10-28   59  	for (i = 0; i < d->chip->num_regs; i++) {
f8beab2b Mark Brown 2011-10-28   60  		ret = regmap_update_bits(d->map, d->chip->mask_base + i,
f8beab2b Mark Brown 2011-10-28   61  					 d->mask_buf_def[i], d->mask_buf[i]);
f8beab2b Mark Brown 2011-10-28   62  		if (ret != 0)
f8beab2b Mark Brown 2011-10-28   63  			dev_err(d->map->dev, "Failed to sync masks in %x\n",
f8beab2b Mark Brown 2011-10-28   64  				d->chip->mask_base + i);
f8beab2b Mark Brown 2011-10-28   65  	}
f8beab2b Mark Brown 2011-10-28   66  
f8beab2b Mark Brown 2011-10-28   67  	mutex_unlock(&d->lock);
f8beab2b Mark Brown 2011-10-28   68  }
f8beab2b Mark Brown 2011-10-28   69  
f8beab2b Mark Brown 2011-10-28   70  static void regmap_irq_enable(struct irq_data *data)
f8beab2b Mark Brown 2011-10-28   71  {
f8beab2b Mark Brown 2011-10-28   72  	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
f8beab2b Mark Brown 2011-10-28   73  	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->irq);
f8beab2b Mark Brown 2011-10-28   74  
f8beab2b Mark Brown 2011-10-28   75  	d->mask_buf[irq_data->reg_offset] &= ~irq_data->mask;
f8beab2b Mark Brown 2011-10-28   76  }
f8beab2b Mark Brown 2011-10-28   77  
f8beab2b Mark Brown 2011-10-28   78  static void regmap_irq_disable(struct irq_data *data)
f8beab2b Mark Brown 2011-10-28   79  {
f8beab2b Mark Brown 2011-10-28   80  	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
f8beab2b Mark Brown 2011-10-28   81  	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->irq);
f8beab2b Mark Brown 2011-10-28   82  
f8beab2b Mark Brown 2011-10-28   83  	d->mask_buf[irq_data->reg_offset] |= irq_data->mask;
f8beab2b Mark Brown 2011-10-28   84  }
f8beab2b Mark Brown 2011-10-28   85  
f8beab2b Mark Brown 2011-10-28   86  static struct irq_chip regmap_irq_chip = {
f8beab2b Mark Brown 2011-10-28   87  	.name			= "regmap",
f8beab2b Mark Brown 2011-10-28   88  	.irq_bus_lock		= regmap_irq_lock,
f8beab2b Mark Brown 2011-10-28   89  	.irq_bus_sync_unlock	= regmap_irq_sync_unlock,
f8beab2b Mark Brown 2011-10-28   90  	.irq_disable		= regmap_irq_disable,
f8beab2b Mark Brown 2011-10-28   91  	.irq_enable		= regmap_irq_enable,
f8beab2b Mark Brown 2011-10-28   92  };
f8beab2b Mark Brown 2011-10-28   93  
f8beab2b Mark Brown 2011-10-28   94  static irqreturn_t regmap_irq_thread(int irq, void *d)
f8beab2b Mark Brown 2011-10-28   95  {
f8beab2b Mark Brown 2011-10-28   96  	struct regmap_irq_chip_data *data = d;
f8beab2b Mark Brown 2011-10-28   97  	struct regmap_irq_chip *chip = data->chip;
f8beab2b Mark Brown 2011-10-28   98  	struct regmap *map = data->map;
f8beab2b Mark Brown 2011-10-28   99  	int ret, i;
f8beab2b Mark Brown 2011-10-28  100  	u8 *buf8 = data->status_reg_buf;
f8beab2b Mark Brown 2011-10-28  101  	u16 *buf16 = data->status_reg_buf;
f8beab2b Mark Brown 2011-10-28  102  	u32 *buf32 = data->status_reg_buf;
f8beab2b Mark Brown 2011-10-28  103  
f8beab2b Mark Brown 2011-10-28  104  	ret = regmap_bulk_read(map, chip->status_base, data->status_reg_buf,
f8beab2b Mark Brown 2011-10-28  105  			       chip->num_regs);
f8beab2b Mark Brown 2011-10-28  106  	if (ret != 0) {
f8beab2b Mark Brown 2011-10-28  107  		dev_err(map->dev, "Failed to read IRQ status: %d\n", ret);
f8beab2b Mark Brown 2011-10-28  108  		return IRQ_NONE;
f8beab2b Mark Brown 2011-10-28  109  	}
f8beab2b Mark Brown 2011-10-28  110  
f8beab2b Mark Brown 2011-10-28  111  	/*
f8beab2b Mark Brown 2011-10-28  112  	 * Ignore masked IRQs and ack if we need to; we ack early so
f8beab2b Mark Brown 2011-10-28  113  	 * there is no race between handling and acknowleding the
f8beab2b Mark Brown 2011-10-28  114  	 * interrupt.  We assume that typically few of the interrupts
f8beab2b Mark Brown 2011-10-28  115  	 * will fire simultaneously so don't worry about overhead from
f8beab2b Mark Brown 2011-10-28  116  	 * doing a write per register.
f8beab2b Mark Brown 2011-10-28  117  	 */
f8beab2b Mark Brown 2011-10-28  118  	for (i = 0; i < data->chip->num_regs; i++) {
f8beab2b Mark Brown 2011-10-28  119  		switch (map->format.val_bytes) {
f8beab2b Mark Brown 2011-10-28  120  		case 1:
f8beab2b Mark Brown 2011-10-28  121  			data->status_buf[i] = buf8[i];
f8beab2b Mark Brown 2011-10-28  122  			break;
f8beab2b Mark Brown 2011-10-28  123  		case 2:
f8beab2b Mark Brown 2011-10-28  124  			data->status_buf[i] = buf16[i];
f8beab2b Mark Brown 2011-10-28  125  			break;
f8beab2b Mark Brown 2011-10-28  126  		case 4:
f8beab2b Mark Brown 2011-10-28  127  			data->status_buf[i] = buf32[i];
f8beab2b Mark Brown 2011-10-28  128  			break;
f8beab2b Mark Brown 2011-10-28  129  		default:
f8beab2b Mark Brown 2011-10-28  130  			BUG();
f8beab2b Mark Brown 2011-10-28  131  			return IRQ_NONE;
f8beab2b Mark Brown 2011-10-28  132  		}
f8beab2b Mark Brown 2011-10-28  133  
f8beab2b Mark Brown 2011-10-28  134  		data->status_buf[i] &= ~data->mask_buf[i];
f8beab2b Mark Brown 2011-10-28  135  
f8beab2b Mark Brown 2011-10-28  136  		if (data->status_buf[i] && chip->ack_base) {
f8beab2b Mark Brown 2011-10-28  137  			ret = regmap_write(map, chip->ack_base + i,
f8beab2b Mark Brown 2011-10-28  138  					   data->status_buf[i]);
f8beab2b Mark Brown 2011-10-28  139  			if (ret != 0)
f8beab2b Mark Brown 2011-10-28  140  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
f8beab2b Mark Brown 2011-10-28  141  					chip->ack_base + i, ret);
f8beab2b Mark Brown 2011-10-28  142  		}
f8beab2b Mark Brown 2011-10-28  143  	}
f8beab2b Mark Brown 2011-10-28  144  
f8beab2b Mark Brown 2011-10-28  145  	for (i = 0; i < chip->num_irqs; i++) {
f8beab2b Mark Brown 2011-10-28  146  		if (data->status_buf[chip->irqs[i].reg_offset] &
f8beab2b Mark Brown 2011-10-28  147  		    chip->irqs[i].mask) {
f8beab2b Mark Brown 2011-10-28 @148  			handle_nested_irq(data->irq_base + i);
f8beab2b Mark Brown 2011-10-28  149  		}
f8beab2b Mark Brown 2011-10-28  150  	}
f8beab2b Mark Brown 2011-10-28  151  
f8beab2b Mark Brown 2011-10-28  152  	return IRQ_HANDLED;
f8beab2b Mark Brown 2011-10-28  153  }
f8beab2b Mark Brown 2011-10-28  154  
f8beab2b Mark Brown 2011-10-28  155  /**
f8beab2b Mark Brown 2011-10-28  156   * regmap_add_irq_chip(): Use standard regmap IRQ controller handling
f8beab2b Mark Brown 2011-10-28  157   *
f8beab2b Mark Brown 2011-10-28  158   * map:       The regmap for the device.
f8beab2b Mark Brown 2011-10-28  159   * irq:       The IRQ the device uses to signal interrupts
f8beab2b Mark Brown 2011-10-28  160   * irq_flags: The IRQF_ flags to use for the primary interrupt.
f8beab2b Mark Brown 2011-10-28  161   * chip:      Configuration for the interrupt controller.
f8beab2b Mark Brown 2011-10-28  162   * data:      Runtime data structure for the controller, allocated on success
f8beab2b Mark Brown 2011-10-28  163   *
f8beab2b Mark Brown 2011-10-28  164   * Returns 0 on success or an errno on failure.
f8beab2b Mark Brown 2011-10-28  165   *
f8beab2b Mark Brown 2011-10-28  166   * In order for this to be efficient the chip really should use a
f8beab2b Mark Brown 2011-10-28  167   * register cache.  The chip driver is responsible for restoring the
f8beab2b Mark Brown 2011-10-28  168   * register values used by the IRQ controller over suspend and resume.
f8beab2b Mark Brown 2011-10-28  169   */
f8beab2b Mark Brown 2011-10-28  170  int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
f8beab2b Mark Brown 2011-10-28  171  			int irq_base, struct regmap_irq_chip *chip,
f8beab2b Mark Brown 2011-10-28  172  			struct regmap_irq_chip_data **data)
f8beab2b Mark Brown 2011-10-28  173  {
f8beab2b Mark Brown 2011-10-28  174  	struct regmap_irq_chip_data *d;
f8beab2b Mark Brown 2011-10-28  175  	int cur_irq, i;
f8beab2b Mark Brown 2011-10-28  176  	int ret = -ENOMEM;
f8beab2b Mark Brown 2011-10-28  177  
f8beab2b Mark Brown 2011-10-28 @178  	irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
f8beab2b Mark Brown 2011-10-28  179  	if (irq_base < 0) {
f8beab2b Mark Brown 2011-10-28  180  		dev_warn(map->dev, "Failed to allocate IRQs: %d\n",
f8beab2b Mark Brown 2011-10-28  181  			 irq_base);
f8beab2b Mark Brown 2011-10-28  182  		return irq_base;
f8beab2b Mark Brown 2011-10-28  183  	}
f8beab2b Mark Brown 2011-10-28  184  
f8beab2b Mark Brown 2011-10-28  185  	d = kzalloc(sizeof(*d), GFP_KERNEL);
f8beab2b Mark Brown 2011-10-28  186  	if (!d)
f8beab2b Mark Brown 2011-10-28  187  		return -ENOMEM;
f8beab2b Mark Brown 2011-10-28  188  
f8beab2b Mark Brown 2011-10-28  189  	d->status_buf = kzalloc(sizeof(unsigned int) * chip->num_regs,
f8beab2b Mark Brown 2011-10-28  190  				GFP_KERNEL);
f8beab2b Mark Brown 2011-10-28  191  	if (!d->status_buf)
f8beab2b Mark Brown 2011-10-28  192  		goto err_alloc;
f8beab2b Mark Brown 2011-10-28  193  
f8beab2b Mark Brown 2011-10-28  194  	d->status_reg_buf = kzalloc(map->format.val_bytes * chip->num_regs,
f8beab2b Mark Brown 2011-10-28  195  				    GFP_KERNEL);
f8beab2b Mark Brown 2011-10-28  196  	if (!d->status_reg_buf)
f8beab2b Mark Brown 2011-10-28  197  		goto err_alloc;
f8beab2b Mark Brown 2011-10-28  198  
f8beab2b Mark Brown 2011-10-28  199  	d->mask_buf = kzalloc(sizeof(unsigned int) * chip->num_regs,
f8beab2b Mark Brown 2011-10-28  200  			      GFP_KERNEL);
f8beab2b Mark Brown 2011-10-28  201  	if (!d->mask_buf)
f8beab2b Mark Brown 2011-10-28  202  		goto err_alloc;
f8beab2b Mark Brown 2011-10-28  203  
f8beab2b Mark Brown 2011-10-28  204  	d->mask_buf_def = kzalloc(sizeof(unsigned int) * chip->num_regs,
f8beab2b Mark Brown 2011-10-28  205  				  GFP_KERNEL);
f8beab2b Mark Brown 2011-10-28  206  	if (!d->mask_buf_def)
f8beab2b Mark Brown 2011-10-28  207  		goto err_alloc;
f8beab2b Mark Brown 2011-10-28  208  
f8beab2b Mark Brown 2011-10-28  209  	d->map = map;
f8beab2b Mark Brown 2011-10-28  210  	d->chip = chip;
f8beab2b Mark Brown 2011-10-28  211  	d->irq_base = irq_base;
f8beab2b Mark Brown 2011-10-28  212  	mutex_init(&d->lock);
f8beab2b Mark Brown 2011-10-28  213  
f8beab2b Mark Brown 2011-10-28  214  	for (i = 0; i < chip->num_irqs; i++)
f8beab2b Mark Brown 2011-10-28  215  		d->mask_buf_def[chip->irqs[i].reg_offset]
f8beab2b Mark Brown 2011-10-28  216  			|= chip->irqs[i].mask;
f8beab2b Mark Brown 2011-10-28  217  
f8beab2b Mark Brown 2011-10-28  218  	/* Mask all the interrupts by default */
f8beab2b Mark Brown 2011-10-28  219  	for (i = 0; i < chip->num_regs; i++) {
f8beab2b Mark Brown 2011-10-28  220  		d->mask_buf[i] = d->mask_buf_def[i];
f8beab2b Mark Brown 2011-10-28  221  		ret = regmap_write(map, chip->mask_base + i, d->mask_buf[i]);
f8beab2b Mark Brown 2011-10-28  222  		if (ret != 0) {
f8beab2b Mark Brown 2011-10-28  223  			dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
f8beab2b Mark Brown 2011-10-28  224  				chip->mask_base + i, ret);
f8beab2b Mark Brown 2011-10-28  225  			goto err_alloc;
f8beab2b Mark Brown 2011-10-28  226  		}
f8beab2b Mark Brown 2011-10-28  227  	}
f8beab2b Mark Brown 2011-10-28  228  
f8beab2b Mark Brown 2011-10-28  229  	/* Register them with genirq */
f8beab2b Mark Brown 2011-10-28  230  	for (cur_irq = irq_base;
f8beab2b Mark Brown 2011-10-28  231  	     cur_irq < chip->num_irqs + irq_base;
f8beab2b Mark Brown 2011-10-28  232  	     cur_irq++) {
f8beab2b Mark Brown 2011-10-28 @233  		irq_set_chip_data(cur_irq, d);
f8beab2b Mark Brown 2011-10-28  234  		irq_set_chip_and_handler(cur_irq, &regmap_irq_chip,
f8beab2b Mark Brown 2011-10-28 @235  					 handle_edge_irq);
f8beab2b Mark Brown 2011-10-28 @236  		irq_set_nested_thread(cur_irq, 1);
f8beab2b Mark Brown 2011-10-28  237  
f8beab2b Mark Brown 2011-10-28  238  		/* ARM needs us to explicitly flag the IRQ as valid
f8beab2b Mark Brown 2011-10-28  239  		 * and will set them noprobe when we do so. */
f8beab2b Mark Brown 2011-10-28  240  #ifdef CONFIG_ARM
f8beab2b Mark Brown 2011-10-28  241  		set_irq_flags(cur_irq, IRQF_VALID);
f8beab2b Mark Brown 2011-10-28  242  #else
f8beab2b Mark Brown 2011-10-28 @243  		irq_set_noprobe(cur_irq);
f8beab2b Mark Brown 2011-10-28  244  #endif
f8beab2b Mark Brown 2011-10-28  245  	}
f8beab2b Mark Brown 2011-10-28  246  

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
