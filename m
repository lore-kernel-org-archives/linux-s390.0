From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:56:28 +0000
Subject: drivers/base/regmap/regmap-irq.c:81:4: error: implicit declaration of function 'irq_set_irq_wake'
Message-Id: <20130329025628.GC10831@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,

FYI, kernel build failed on s390 since

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: a43fd50dc99a5f65505f174eca5a421707d73b4c regmap: Implement support for wake IRQs
date:   10 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   In file included from drivers/base/regmap/regmap-irq.c:21:0:
   drivers/base/regmap/internal.h:129:52: warning: 'struct regmap_config' declared inside parameter list [enabled by default]
   drivers/base/regmap/internal.h:129:52: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'irq_to_regmap_irq':
   drivers/base/regmap/regmap-irq.c:47:20: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:50:36: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_lock':
   drivers/base/regmap/regmap-irq.c:52:9: error: implicit declaration of function 'irq_data_get_irq_chip_data' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:52:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:57:43: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_sync_unlock':
   drivers/base/regmap/regmap-irq.c:59:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:68:25: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:69:43: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:75:12: error: dereferencing pointer to incomplete type
>> drivers/base/regmap/regmap-irq.c:81:4: error: implicit declaration of function 'irq_set_irq_wake' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:91:38: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_enable':
   drivers/base/regmap/regmap-irq.c:93:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:95:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:97:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:97:66: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:100:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_disable':
   drivers/base/regmap/regmap-irq.c:102:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:104:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:106:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:106:65: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:109:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_set_wake':
   drivers/base/regmap/regmap-irq.c:111:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:113:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:115:14: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:119:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:120:16: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:123:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:124:15: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:131:15: error: variable 'regmap_irq_chip' has initializer but incomplete type
   drivers/base/regmap/regmap-irq.c:132:2: error: unknown field 'name' specified in initializer
   drivers/base/regmap/regmap-irq.c:132:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:132:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:133:2: error: unknown field 'irq_bus_lock' specified in initializer
   drivers/base/regmap/regmap-irq.c:133:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:133:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:134:2: error: unknown field 'irq_bus_sync_unlock' specified in initializer
   drivers/base/regmap/regmap-irq.c:134:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:134:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:135:2: error: unknown field 'irq_disable' specified in initializer
   drivers/base/regmap/regmap-irq.c:135:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:135:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:136:2: error: unknown field 'irq_enable' specified in initializer
   drivers/base/regmap/regmap-irq.c:136:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:136:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:137:2: error: unknown field 'irq_set_wake' specified in initializer
   drivers/base/regmap/regmap-irq.c:137:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:137:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_thread':
   drivers/base/regmap/regmap-irq.c:155:28: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:156:30: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:168:34: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:169:32: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:175:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:180:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:181:28: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:182:33: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:183:4: error: implicit declaration of function 'handle_nested_irq' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:183:4: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_map':
   drivers/base/regmap/regmap-irq.c:199:2: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:200:2: error: implicit declaration of function 'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:200:51: error: 'handle_edge_irq' undeclared (first use in this function)
   drivers/base/regmap/regmap-irq.c:200:51: note: each undeclared identifier is reported only once for each function it appears in
   drivers/base/regmap/regmap-irq.c:201:2: error: implicit declaration of function 'irq_set_nested_thread' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:208:2: error: implicit declaration of function 'irq_set_noprobe' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:216:11: error: 'irq_domain_xlate_twocell' undeclared here (not in a function)
   drivers/base/regmap/regmap-irq.c: In function 'regmap_add_irq_chip':
   drivers/base/regmap/regmap-irq.c:242:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:243:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:245:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:246:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:251:3: error: implicit declaration of function 'irq_alloc_descs' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:251:47: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:265:53: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:270:51: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:275:55: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:280:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:281:52: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:292:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:293:27: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:299:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:300:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:301:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:304:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:306:31: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:311:9: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:317:3: error: implicit declaration of function 'irq_domain_add_legacy' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:318:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:321:3: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:322:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:331:12: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_get_virq':
   drivers/base/regmap/regmap-irq.c:397:17: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:400:2: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/irq_set_irq_wake +81 drivers/base/regmap/regmap-irq.c

f01ee60f Stephen Warren 2012-04-09  69  		ret = regmap_update_bits(d->map, d->chip->mask_base +
022f926a Graeme Gregory 2012-05-14  70  						(i * map->reg_stride *
022f926a Graeme Gregory 2012-05-14  71  						d->irq_reg_stride),
f8beab2b Mark Brown     2011-10-28  72  					 d->mask_buf_def[i], d->mask_buf[i]);
f8beab2b Mark Brown     2011-10-28  73  		if (ret != 0)
f8beab2b Mark Brown     2011-10-28  74  			dev_err(d->map->dev, "Failed to sync masks in %x\n",
f01ee60f Stephen Warren 2012-04-09 @75  				d->chip->mask_base + (i * map->reg_stride));
f8beab2b Mark Brown     2011-10-28  76  	}
f8beab2b Mark Brown     2011-10-28  77  
a43fd50d Mark Brown     2012-06-05  78  	/* If we've changed our wakeup count propagate it to the parent */
a43fd50d Mark Brown     2012-06-05  79  	if (d->wake_count < 0)
a43fd50d Mark Brown     2012-06-05  80  		for (i = d->wake_count; i < 0; i++)
a43fd50d Mark Brown     2012-06-05 @81  			irq_set_irq_wake(d->irq, 0);
a43fd50d Mark Brown     2012-06-05  82  	else if (d->wake_count > 0)
a43fd50d Mark Brown     2012-06-05  83  		for (i = 0; i < d->wake_count; i++)
a43fd50d Mark Brown     2012-06-05  84  			irq_set_irq_wake(d->irq, 1);

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
