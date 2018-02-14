From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 14 Feb 2018 18:54:25 +0000
Subject: [kvms390:next 4/6] drivers/video/fbdev/s1d13xxxfb.c:822:22: error: implicit declaration of function 
Message-Id: <201802150216.frj6w5Y6%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--UlVJffcvxoiEqYs2"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
head:   03ef4828b20c549d5ae7dd082b157ebb51d9533a
commit: 32673fe14954013acc5004886314f5759174e90a [4/6] Kconfig : Remove HAS_IOMEM dependency for Graphics support
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 32673fe14954013acc5004886314f5759174e90a
        # save the attached .config to linux build tree
        make ARCH=um 

All error/warnings (new ones prefixed by >>):

   drivers/video/fbdev/s1d13xxxfb.c: In function 's1d13xxxfb_probe':
>> drivers/video/fbdev/s1d13xxxfb.c:822:22: error: implicit declaration of function 'ioremap_nocache'; did you mean 'devm_ioremap_nocache'? [-Werror=implicit-function-declaration]
     default_par->regs = ioremap_nocache(pdev->resource[1].start,
                         ^~~~~~~~~~~~~~~
                         devm_ioremap_nocache
>> drivers/video/fbdev/s1d13xxxfb.c:822:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     default_par->regs = ioremap_nocache(pdev->resource[1].start,
                       ^
   drivers/video/fbdev/s1d13xxxfb.c:831:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     info->screen_base = ioremap_nocache(pdev->resource[0].start,
                       ^
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_platdata
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_get_drvdata
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 1 arch/um/include/asm/io.h:iounmap
   Cyclomatic Complexity 1 include/asm-generic/io.h:__raw_readb
   Cyclomatic Complexity 1 include/asm-generic/io.h:__raw_writeb
   Cyclomatic Complexity 1 include/asm-generic/io.h:readb
   Cyclomatic Complexity 1 include/asm-generic/io.h:writeb
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_readreg
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_writereg
   Cyclomatic Complexity 8 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_runinit
   Cyclomatic Complexity 2 drivers/video/fbdev/s1d13xxxfb.c:lcd_enable
   Cyclomatic Complexity 2 drivers/video/fbdev/s1d13xxxfb.c:crt_enable
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_setup_pseudocolour
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_setup_truecolour
   Cyclomatic Complexity 6 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_set_par
   Cyclomatic Complexity 6 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_setcolreg
   Cyclomatic Complexity 6 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_blank
   Cyclomatic Complexity 4 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_pan_display
   Cyclomatic Complexity 5 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_remove
   Cyclomatic Complexity 3 drivers/video/fbdev/s1d13xxxfb.c:bltbit_wait_bitclear
   Cyclomatic Complexity 4 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_bitblt_copyarea
   Cyclomatic Complexity 2 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_bitblt_solidfill
   Cyclomatic Complexity 6 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_fetch_hw_state
   Cyclomatic Complexity 21 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_probe
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_init
   Cyclomatic Complexity 1 drivers/video/fbdev/s1d13xxxfb.c:s1d13xxxfb_exit
   cc1: some warnings being treated as errors
--
   drivers/video/fbdev/uvesafb.c: In function 'uvesafb_ioremap':
>> drivers/video/fbdev/uvesafb.c:1538:22: error: implicit declaration of function 'ioremap_wc'; did you mean 'ioremap_uc'? [-Werror=implicit-function-declaration]
     info->screen_base = ioremap_wc(info->fix.smem_start, info->fix.smem_len);
                         ^~~~~~~~~~
                         ioremap_uc
>> drivers/video/fbdev/uvesafb.c:1538:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     info->screen_base = ioremap_wc(info->fix.smem_start, info->fix.smem_len);
                       ^
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/bitops.h:fls_long
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/log2.h:__roundup_pow_of_two
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/um/include/asm/thread_info.h:current_thread_info
   Cyclomatic Complexity 1 include/asm-generic/preempt.h:preempt_count
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_dec
   Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/completion.h:__init_completion
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 arch/um/include/asm/io.h:iounmap
   Cyclomatic Complexity 1 include/linux/io.h:arch_phys_wc_add
   Cyclomatic Complexity 1 include/linux/io.h:arch_phys_wc_del
   Cyclomatic Complexity 2 include/net/sock.h:gfp_any
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_get_drvdata
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_setup_var
   Cyclomatic Complexity 11 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_find_mode
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:uvesafb_pan_display
   Cyclomatic Complexity 14 drivers/video/fbdev/uvesafb.c:uvesafb_init_info
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:v86d_store
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:v86d_show
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_prep
   Cyclomatic Complexity 2 drivers/video/fbdev/uvesafb.c:uvesafb_free
   Cyclomatic Complexity 2 drivers/video/fbdev/uvesafb.c:uvesafb_remove
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_store_nocrtc
   Cyclomatic Complexity 2 drivers/video/fbdev/uvesafb.c:uvesafb_show_nocrtc
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_show_oem_string
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_show_product_rev
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_show_product_name
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_show_vendor
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_show_vbe_modes
   Cyclomatic Complexity 2 drivers/video/fbdev/uvesafb.c:uvesafb_show_vbe_ver
   Cyclomatic Complexity 71 drivers/video/fbdev/uvesafb.c:uvesafb_init_mtrr
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:uvesafb_helper_start
   Cyclomatic Complexity 11 drivers/video/fbdev/uvesafb.c:uvesafb_exec
   Cyclomatic Complexity 7 drivers/video/fbdev/uvesafb.c:uvesafb_blank
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_setpalette
   Cyclomatic Complexity 7 drivers/video/fbdev/uvesafb.c:uvesafb_setcolreg
   Cyclomatic Complexity 7 drivers/video/fbdev/uvesafb.c:uvesafb_setcmap
   Cyclomatic Complexity 5 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_state_restore
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_release
   Cyclomatic Complexity 6 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_state_save
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_open
   Cyclomatic Complexity 9 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_getinfo
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:uvesafb_reset
   Cyclomatic Complexity 21 drivers/video/fbdev/uvesafb.c:uvesafb_set_par
   Cyclomatic Complexity 12 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_getmodes
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_getstatesize
   Cyclomatic Complexity 10 drivers/video/fbdev/uvesafb.c:uvesafb_check_limits
   Cyclomatic Complexity 11 drivers/video/fbdev/uvesafb.c:uvesafb_check_var
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_is_valid_mode
   Cyclomatic Complexity 14 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_getedid
   Cyclomatic Complexity 15 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_getmonspecs
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_init
   Cyclomatic Complexity 14 drivers/video/fbdev/uvesafb.c:uvesafb_vbe_init_mode
   Cyclomatic Complexity 1 drivers/video/fbdev/uvesafb.c:uvesafb_ioremap
   Cyclomatic Complexity 11 drivers/video/fbdev/uvesafb.c:uvesafb_probe
   Cyclomatic Complexity 9 drivers/video/fbdev/uvesafb.c:uvesafb_cn_callback
   Cyclomatic Complexity 4 drivers/video/fbdev/uvesafb.c:param_set_scroll
   Cyclomatic Complexity 6 drivers/video/fbdev/uvesafb.c:uvesafb_init
   Cyclomatic Complexity 3 drivers/video/fbdev/uvesafb.c:uvesafb_exit
   cc1: some warnings being treated as errors
--
   In file included from drivers/video/fbdev/core/fbmem.c:38:0:
   arch/x86/include/asm/fb.h: In function 'fb_pgprotect':
>> arch/x86/include/asm/fb.h:14:42: error: '_PAGE_CACHE_MASK' undeclared (first use in this function); did you mean '_PAGE_CHG_MASK'?
     prot = pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK;
                                             ^~~~~~~~~~~~~~~~
                                             _PAGE_CHG_MASK
   arch/x86/include/asm/fb.h:14:42: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/include/asm/fb.h:15:19: error: 'struct cpuinfo_um' has no member named 'x86'
     if (boot_cpu_data.x86 > 3)
                      ^
>> arch/x86/include/asm/fb.h:17:11: error: implicit declaration of function 'cachemode2protval' [-Werror=implicit-function-declaration]
       prot | cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
              ^~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/fb.h:17:29: error: '_PAGE_CACHE_MODE_UC_MINUS' undeclared (first use in this function); did you mean '_PAGE_CACHE_MASK'?
       prot | cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
                                _PAGE_CACHE_MASK
   cc1: some warnings being treated as errors

vim +822 drivers/video/fbdev/s1d13xxxfb.c

^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  764  
48c68c4f1 drivers/video/s1d13xxxfb.c Greg Kroah-Hartman 2012-12-21  765  static int s1d13xxxfb_probe(struct platform_device *pdev)
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  766  {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  767  	struct s1d13xxxfb_par *default_par;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  768  	struct fb_info *info;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  769  	struct s1d13xxxfb_pdata *pdata = NULL;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  770  	int ret = 0;
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  771  	int i;
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  772  	u8 revision, prod_id;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  773  
28822f22e drivers/video/s1d13xxxfb.c Stanislav Brabec   2007-11-14  774  	dbg("probe called: device is %p\n", pdev);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  775  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  776  	printk(KERN_INFO "Epson S1D13XXX FB Driver\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  777  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  778  	/* enable platform-dependent hardware glue, if any */
772ee6daf drivers/video/s1d13xxxfb.c Jingoo Han         2013-09-17  779  	if (dev_get_platdata(&pdev->dev))
772ee6daf drivers/video/s1d13xxxfb.c Jingoo Han         2013-09-17  780  		pdata = dev_get_platdata(&pdev->dev);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  781  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  782  	if (pdata && pdata->platform_init_video)
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  783  		pdata->platform_init_video();
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  784  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  785  	if (pdev->num_resources != 2) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  786  		dev_err(&pdev->dev, "invalid num_resources: %i\n",
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  787  		       pdev->num_resources);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  788  		ret = -ENODEV;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  789  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  790  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  791  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  792  	/* resource[0] is VRAM, resource[1] is registers */
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  793  	if (pdev->resource[0].flags != IORESOURCE_MEM
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  794  			|| pdev->resource[1].flags != IORESOURCE_MEM) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  795  		dev_err(&pdev->dev, "invalid resource type\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  796  		ret = -ENODEV;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  797  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  798  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  799  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  800  	if (!request_mem_region(pdev->resource[0].start,
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  801  		pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) {
3ae5eaec1 drivers/video/s1d13xxxfb.c Russell King       2005-11-09  802  		dev_dbg(&pdev->dev, "request_mem_region failed\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  803  		ret = -EBUSY;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  804  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  805  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  806  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  807  	if (!request_mem_region(pdev->resource[1].start,
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  808  		pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) {
3ae5eaec1 drivers/video/s1d13xxxfb.c Russell King       2005-11-09  809  		dev_dbg(&pdev->dev, "request_mem_region failed\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  810  		ret = -EBUSY;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  811  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  812  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  813  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  814  	info = framebuffer_alloc(sizeof(struct s1d13xxxfb_par) + sizeof(u32) * 256, &pdev->dev);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  815  	if (!info) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  816  		ret = -ENOMEM;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  817  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  818  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  819  
98365f5eb drivers/video/s1d13xxxfb.c Antonino A. Daplas 2006-03-11  820  	platform_set_drvdata(pdev, info);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  821  	default_par = info->par;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16 @822  	default_par->regs = ioremap_nocache(pdev->resource[1].start,
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  823  			pdev->resource[1].end - pdev->resource[1].start +1);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  824  	if (!default_par->regs) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  825  		printk(KERN_ERR PFX "unable to map registers\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  826  		ret = -ENOMEM;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  827  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  828  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  829  	info->pseudo_palette = default_par->pseudo_palette;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  830  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  831  	info->screen_base = ioremap_nocache(pdev->resource[0].start,
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  832  			pdev->resource[0].end - pdev->resource[0].start +1);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  833  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  834  	if (!info->screen_base) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  835  		printk(KERN_ERR PFX "unable to map framebuffer\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  836  		ret = -ENOMEM;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  837  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  838  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  839  
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  840  	/* production id is top 6 bits */
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  841  	prod_id = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE) >> 2;
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  842  	/* revision id is lower 2 bits */
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  843  	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE) & 0x3;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  844  	ret = -ENODEV;
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  845  
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  846  	for (i = 0; i < ARRAY_SIZE(s1d13xxxfb_prod_ids); i++) {
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  847  		if (prod_id == s1d13xxxfb_prod_ids[i]) {
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  848  			/* looks like we got it in our list */
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  849  			default_par->prod_id = prod_id;
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  850  			default_par->revision = revision;
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  851  			ret = 0;
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  852  			break;
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  853  		}
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  854  	}
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  855  
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  856  	if (!ret) {
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  857  		printk(KERN_INFO PFX "chip production id %i = %s\n",
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  858  			prod_id, s1d13xxxfb_prod_names[i]);
0b178883b drivers/video/s1d13xxxfb.c Kristoffer Ericson 2008-10-15  859  		printk(KERN_INFO PFX "chip revision %i\n", revision);
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  860  	} else {
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  861  		printk(KERN_INFO PFX
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  862  			"unknown chip production id %i, revision %i\n",
afbb9d8d5 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-03-31  863  			prod_id, revision);
a895d57da drivers/video/s1d13xxxfb.c Masanari Iida      2013-04-09  864  		printk(KERN_INFO PFX "please contact maintainer\n");
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  865  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  866  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  867  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  868  	info->fix = s1d13xxxfb_fix;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  869  	info->fix.mmio_start = pdev->resource[1].start;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  870  	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start + 1;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  871  	info->fix.smem_start = pdev->resource[0].start;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  872  	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start + 1;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  873  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  874  	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  875  	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  876  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  877  	info->par = default_par;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  878  	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  879  	info->fbops = &s1d13xxxfb_fbops;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  880  
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  881  	switch(prod_id) {
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  882  	case S1D13506_PROD_ID:	/* activate acceleration */
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  883  		s1d13xxxfb_fbops.fb_fillrect = s1d13xxxfb_bitblt_solidfill;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  884  		s1d13xxxfb_fbops.fb_copyarea = s1d13xxxfb_bitblt_copyarea;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  885  		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  886  			FBINFO_HWACCEL_FILLRECT | FBINFO_HWACCEL_COPYAREA;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  887  		break;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  888  	default:
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  889  		break;
3ed167af9 drivers/video/s1d13xxxfb.c Kristoffer Ericson 2009-06-16  890  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  891  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  892  	/* perform "manual" chip initialization, if needed */
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  893  	if (pdata && pdata->initregs)
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  894  		s1d13xxxfb_runinit(info->par, pdata->initregs, pdata->initregssize);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  895  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  896  	s1d13xxxfb_fetch_hw_state(info);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  897  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  898  	if (register_framebuffer(info) < 0) {
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  899  		ret = -EINVAL;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  900  		goto bail;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  901  	}
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  902  
31b6780c1 drivers/video/s1d13xxxfb.c Joe Perches        2013-09-19  903  	fb_info(info, "%s frame buffer device\n", info->fix.id);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  904  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  905  	return 0;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  906  
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  907  bail:
3ae5eaec1 drivers/video/s1d13xxxfb.c Russell King       2005-11-09  908  	s1d13xxxfb_remove(pdev);
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  909  	return ret;
^1da177e4 drivers/video/s1d13xxxfb.c Linus Torvalds     2005-04-16  910  

:::::: The code at line 822 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UlVJffcvxoiEqYs2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNqEhFoAAy5jb25maWcAlFtZc+O2k3/Pp2BNqraSqhySfIxmt/wAgqCEiCRoAJQlv7AU
W5NRxddKcpL59tsNkiIAQvPPPiRj/rpx9w3o++++j8j78fV5c9w9bJ6evkZ/bF+2+81x+xh9
3j1t/ydKRFQIHbGE61+AuTps91H++riNst3L+z+//jO9ji5/GV//Mvp5/zCOFtv9y/Ypoq8v
n3d/vEM/u9eX777/jooi5bO6yrObr91Hnlf9RyFqLnKW94iWhLKay9s0IzNVq6oshdQ9PRN0
kbBySFCa0EXTekCbsYJJTmtKMh5LolmdsIyse4b5/c14NDrNSta0rNTN+DtYA6w9z34+vG0f
dp93D9HrG67tAARDm78ejtHb/vVhezi87qPj17dttHmBTdxuju/77cEwdStfTKPdIXp5PUaH
7dHCS0XDBCokm4RJRIvcpvgrLa1dXk2va15oJguRMNgEOoc9mvNU31zbLNn4PE0r6vZH83JF
57PrSx8WSxfJecHzKscZ1SnJeba+ub7sGEopKFNKyFqxjFHryJAdztHMOxvCJE+GIGWFJpXs
CXByOIceuL6MOQ5y2kec4cUksJFIsBdHJJ2D1KTN582Hzf7hy6/vz78+GJE/oEIAf/24/dwg
H7qG8k6xvMa9IklSk2wmJNfz3J5Ew9IdnSp5gVIemNRFnbEly+pypkmcMWV3YiY4J6Ay0AWf
FSRTQckxfJJVitVzoXS9VGsFepEBgZFvSNT8jvHZ3FU4DXjGi0UPgtZqR58RqI3cAQxiW9pz
npMlq2MhsAmcdCoMZ2ASqsy4rkuN+9Lo5kmEqMhLQjUXhWVj+Ay03IHK+VrVcAKy1icpaEkL
Zc0XjphUmQYzRUqUXdPm5nL06drbwjtSaFXrOZiiO1IG5lwwltQlM7akXlhD0IyRwmiatU1S
QHd3Znta6N77LIWwFOE+rpKb59PXRSoy+1vlcKSC9kgrMngCIF8ze5iG1ZxnD/MEmEsyY8Yi
L5wmsCijctBAWUYWNDBmBZ3nRFoSkSUgkZKXuhWYnhLDiee6ZlnaY/CBRs/aLPiqkyovTycD
LPWckYRJNeirGQlW7YoYEZUOnFDbKOfK2igcEMeznAOoSap6DjDLhRKZNcmczFBx10reWmIF
9hZ01filWkiYLziUkxOEYwDg1Cc4wiQn1ha3x2X0Xd1cnBSBURR465zkbX0nzIYbXzMzfvwJ
l/n+1rvgWIoFK2pR1MppXYBasWIJIg0nxXNQi/FketoKKZQyCsZhtR9OJg2khWRL2H/UsDBc
k0qLoVbhVhYkh85+eHl92f54auvKOuzkkpd0AOC/VFtaUArFV3V+W7GKhdFBk2ZRYHCEXNdE
w+nMLYcBbojHltWvEttSNMKE2m8IreX02MMo2Attj9SAWjLWnRycZHR4//3w9XDcPvcn19lf
PGg1F3fu0SciJ7xwMcUtY2M3T1hczVI1JFK0qyBphdFnMxu9e97uD6EJgQ6DPBcMJmNtDQjw
/B5lJTdWt9e/ezQXXCSchmykaYW2xuvJ2nPwOuCvwNTyvFH5JqYqq1/15vBndISJmpDrcNwc
D9Hm4eH1/eW4e/nDmzFaLALKUxXaMWaxSrowBOn6PKVeXlhxKlELzwAi1ASWXkeGsApgXLhT
MiuTtIpUaNuLdQ20vgv4qNkKdtd2yg6HaeNBOO+2nz4AocaaQxDQHGAwcEAm49MUm9E44ypo
UisOBh8M68TSXr5oo6ZnHzH7awf32EPaBqDjj32YCGHgolYkZT7PyTLSmRRVaR2HcV5mc5kV
EoLi05n36VmfHgPTiFbYCjXjbNGOZBs3UKsgpfmu7yDiYzG4gQFFQRBg9Z4SLusghaaqjkmR
3PFEW1ZE6jPsDVryRA1A6TiaFkzBEN3b+9TiCVtyymxZaQmgTijQARFoGeIyDfQGO2UJq4nm
WhLR1qzQRygI65g1/QrCrcL6Rn9gf4Ptlg4Aq3e+C6adb7NnxlF5xwYWHLYbskzJKCSLyXlK
vZxYh+HmlCgQsH3Gx0qrD/NNcuhHiUpS27HKpJ7dc2smAMQATBwku7cPEIDVvUcX3reVx1Ba
ixJMKb9ndQp5F5gP+CeHgNQ9ZY9NwR+huNxzrqQA188xiLf22XjNiidjKxFzpMM3Yh5vDpED
x9O1zmHGdI4WdOBsmxMKwTDRIZ7OQamyQexw8jWOAbKmb4sxBqRu0BoTyK7Syhmo0mzlfYKE
ervUwG1ubY1QCmcxJr1LLZky87UB48xtQM2dtIxwS0ZIsuSKdZtjLRuaxERK7hiGOaOLUsB+
oFfWzroX2HydqyFSN7t+kq8ejyGUhlW3SUVAxk6sZldRyTRfMkeUhueK4mJCTmdT8pglia3P
JR2PLjvH2xaxyu3+8+v+efPysI3YX9sXCCoIhBcUwwoIiXqPvMybbe6cjG1asioeWDvEWt9i
hNROT00WqyFMX9i7pDISh7QOenLZRJiN4IByxrr4254M0NDoox+vJSiByM9R5wSSl8Izgxoy
drTZNQT8POXUT7elSHnmBFqmNmcEx7cNJh8HCQGxRoNMMeIKBd1t8lNDz45PP4ebljMwZWVW
zbht+v8DWNM1NUeSsRXX6yCLApNp17osEkgoigX8J0V5prWWFRgkRhb/gVzHa8lSX33CrHAU
sVAhO23x41k3bYIj92TPNXSnOMeaCJwG6KB/SEsO8YgbZ2OKYdkTkVQZhPJYfEKricp849eD
ukLWPBiFckXA+oLdKHmQjsNDBsFSkEmOp5Cm4TpYP9YSSz0mTT9fMENnKMDodlm9vFv9v5g7
DTzfyJTuNGRj+l+NYbE3u+qzn4KS1JxF546aIgFI7s+/bw7bx+jPxui97V8/756crAmZ2qnc
hOqMht7oOUP5DIodsBgZ0ibOSphuiryWIPccF/VlcL02z2X98fxpduksBLigvXMm4fxDWwJb
hn7Wll/jW0wl7GbkSasvvjgVinkISQakqgjCTYsAsa2WOIXctg2kbadaSnBzOz4+G4ynMMLA
MYMUx1FauJqTcWgiDWkyCZ+Ox3V1/S+4Lqb/pq+rcagwb/Ggkbj5cPiyGX/wqGi7peNFPEIX
Z/tDn+ir+7NjK1O2AQEQCztriLGI4ob/iioOGnhbQaA0TAxiNQuCTgWqzyI0m0nHGXWke1H4
KSrCei6F1q4PHtJgGXcuneYJELD4K52YG2l3sR4AtbodYvmtPyjmyHbtyewPuHtRkpNdKjf7
4w7v1yL99W1rhVowF8210YVkiQ7JWi+B2LvoOc4SalqBLyPn6YwpsTpP5lSdJ5Ik/Qa1FHeQ
4DB6nkNyRbk9OCQhgSUJlQZXmvMZCRI0kTxEyAkNwioRKkTAWljC1QICQ/s6Di/3VrWq4kAT
iOthcGVu0gLkClreESzuD7vNkjzUBGE/qJ4FlweeVoZ3UFVBWVkQcC8hAkuDA2BB+noaoljq
cyI19V0RqYcv28f3JyeL4KKpQxRC2IX5Fk0YMd1ZpbOWQtNb69IivW0LQS2576krvbv9d2jH
/uHl9fWtt6K335iARVysY/sSo4Nje2rx+akRVYwdgSjMzuEFqHGWtjntC1TdnXxEv2z2mwfI
yaJk+9fuwbYXSidMSrDm3kWNUpaUFRUWPOfETlsERrAupNceogfICtKOvMNOLqUQ3ekAIVQo
A72HJYmm4YfPj/89+gn+1zszZGho/8Aqnz9Yq2jxt+PXE4qX3QpCPesaMPRZN3c6dtqOtzJ4
HyGA1exus59Rst/91chqf7W0e2jhSJxeQnQTaLLhOctK2284MKiFnlsVL3BGOi9t29kh4Gwh
bLWOTkNmQjLwdXaW2fSdcpkbW2LKz5bQ3JkwzZZRtoI89NTAmsmJtykk+qsIkusUYim3sIvX
wsbFDu8R8Zr17gztHIpeM5GQa8kBypaSKR/VEGm0DSDwyIVdKDE0otYF7Tggeo+ZfVsKZq2e
r2FlS66E/Pb7krY2bE1BslluF9Kb75pPrOvVFlNlzgcgt69PMYiHIFCiPanS1NkAIKUMooCm
ptDZhPj9ED36lgD+KSDnEJYI5DpxPszGKBeCYfFdgrHiZ0gJl6bjdRv5/Tw+2wFYM3PH7haT
h2wSjK0osrXLY3sUby4iDaFEfjzBXlz1ttkfLJXunnWBT2qqXHq/eTk8mfdbUbb56ngq7Bqi
Njh2b7xm/UOolqJHU51Z192DL0hfLe/n0mWauM2VShNLplTuks3OiNKbpbnkcZCTiwYZy4nS
vXuRJP9VivzX9Glz+BI9fNm9RY8nY2gfTcrdLn9jCaOdWlk46E0dgKE9RrRtxUB55w7EQrR3
U32i0lJisHZrzQavTwaM2RlGj23GRM609GQP1TImBQT1ePFUj79JnXyTevlN6vTb415/k3wx
Ge4cHwewEN9lAPNmI3QZYMKXaeBOAieaJ8q3MYiDCyNDtNLck12QPg8QHkBiBX7PxQrwjzWj
NIyCklB3DUgJ8MZ0fqaH2LxfcOQLNO8bN8an1sKcF503/vmMEBpO/B++X2gNV1YmiYz+q/l3
EpU0j563z6/7r2F1NGzu7G/Ns7KA6kGUCdolg6ApUF5ifooG3lPLKvZ0HoD6LsOcGt9EQPxh
Xot5DDGL2wc2k5FPS8H2OI6zI8yyioVG80oNibaOVqT23xhVa+2UHwDER3nt05MeZERm6zBp
IeLfHCBZF5BzOqOah3JOyQUwx6PDd8HcieRN0NkD0IPIlu7oEMTI0M3qsKxhInr4sLIPj1K3
aU/xG/PeDNKk0bKT9N6DGoZeOLQ9VnGg5gJgjQHWkEIh9Du9jvFoGaZmgykjal4gmvrtzXTQ
o1yXWoTbJjK2dBu/zi/8tEV2kw50TJEFtpMaX4doeFnsKAHeE+Ep1kzPA92ZgY2+F8ucRer9
7e11f+xVG9EmZXl2IHMxbBKKrw6eklhitcbl1kTOmA6C3QmYOeS7w8MwjiTJ1eRqVSelsLqw
QDfKhTA+Xxvp75Njqj5dTNTlaGwlIwXNhKogcVEYcmMw3fddJurTdDQhmQVylU0+jUYXPjIZ
WdEQg6RXqloD5eoqQIjn448fA7gZ8dNo1VPmOb2+uJpY61Lj66n1XakY4gquwbSniny6nI5s
DcKHlTWEoaF7CToxT/TbPWcMLHQeHfyTb3CQn8mltWsNmLEZoesBnJPV9fTj1QD/dEFX1wMU
wod6+mleMrXq5qK3/2wOEX85HPfvz+b69/Bls98+RkeMjXF+0dPuZRs9gpzs3vBP+5EWOPmu
I/IEWfsmSssZiT7v9s9/Qy/R4+vfL0+vm8fo2UTd0Q/77f++7/YQfoMA/WjJG15lEgwZyqzr
kL8ct08R2F3wiPvtk/m1Rr9lHgtmQ02m3tEU5WkAXooygPYdmZ84nCPSzf4xNMxZ/tf+xxLq
CCuI8s3L5o8tbnT0AxUq/9EvO+D8Tt11p0fnwpY0usrMFU74ShCIJK26pBcSg7NsGY+DNBEa
oF2t4q21GIqvqf/nwrKrkvAEX51KS6mRy0nCsRXkuKErfSSBE3Uf3TfD3AZu+ZGAT+yayns/
4Xamze9VfgBJ/vOn6Lh52/4U0eRn0AtLEDsrraxV0LlsMD3EhLLRU2sZwuolKxLhPC5pO54F
BrMDU7Oyk/n0cPgbq0VaeTuRidnMuQ4xqKKkaMoizhbpTtsP3nlijBg4wTqlQZib/4coiqiz
OAgi/BMgmN9sOG+4G5Isg31l4s48Ibdya4NrakUNDWTqEOZlSk+BaaTU+xT+djcleQ+bexNM
5rVMCB2w1eYHFEOY5QFeklXEQ4VKzIs6Tpwaz4lW2T+LOKGJedBlPB/rX+X3ZPeSIQ9Eermd
OyX4KxiInx0IVX00QMZDZMh0eXXtYH2gY6NG2dcORLPKlDF6XWt+Z+J9+wts0Vab1IDcRZW5
SeA0D0SPiRUnAl/IGg1vb0yHqZ0CdDxtAQkv7GZgs/HD0VyPr/mRBVYDfa6YY/bHFUS89iAl
Xq0r80zHvDy1aVWBDytKljioCbcdRBWkNI/gbdC8jwGTu+R4dY+zcTpxT6NDQKFvHRRcv7ud
XEpbvAHCd9BYijbPZB0KSpAD4CWD291Qnmy0vs3OEJT2jgrzMmfvTEHeOQHIKBfM5cI3YzoE
1al9SYp7bILLwcLNi2rlwP0FubN0czd+Qtpw380lNIXWXg0TMXzYYssmYmXrrC0ID8EKiTGV
iI00evmG6dIyaq0h9rMSpgd19aKbcq91okhc2cKEw4pubyuS8Xvnci6NnVFqzezcrkMwXGH4
cyGSUKL0OQaJV0lSxLw4y9G8KTxDxV/sLc2b+Ko8x4P3LTHJzPuz3sgRugTIBbRd2eWlywDf
Dn25csh4o7G0Bpjp0ulcMepMkLZ3igFsWBYBmvt0F1eICMYoWsIf9r2GrgpbVK15AKVeGjEw
v16yrzSXTk5dZLnwjmQpUyur1HkbB9vPFRB0BQihJkZofm1DIKbv859B8Q3peC9qRW2IzI2u
NFeKO8indr+/Y86i/t4dH75EZP/wZXfcPuAPpYddxldWlgsfplbU3YU5C0wU8UooHZrrj1cX
owC+nE7Z9eja9rwctpbOeVkv1P25FqvV6hukepYJkNeJe9rIckvJdDFsqXLIj0EYP13YGX2I
6lYXghxuKQ2EAl/uaXcuTbgNYRShaEDt36PZ5Jzc2wUimwR2pYBYK0yUNIxX4LvCTcCqQTQR
prF7PI4gaV6RO8aDJO/34jZlOrlarYKknEiIkcPNciCQwn4YlGcrdef5kB6rcedzkvn8zgk2
kPlpPMkcOL3ztLeZRUG0Ynl4yfCnFIXIWZA6vfg0ChLQRWBFsieCmH4cjSylaIG6ItLyBDIv
PI/VdSnBlmLaEhpO4k8MZZCkSK4qO26zafiKCEIIGV6dEhTv71ZhQV+ekVRI9kQJqY4d4qNx
aX7s9OyAcaV8hOuY2M7XoLPS1r9yvsZnfH3mcQdIP1zGEohW+Qxj24bQlB45j+CzqycMbCKB
EB/ZezPd6qOH6unoYuViMc0/oo3ywenHANi4KW8JTUwgcpebckoSb/xWq10wIbC5fuuknF5M
J5MAeDkNgNcfXTDlK+btCKcl5EAehjahXt2RtYtnWEPQ49F4TD3CSrtAayDC4Hg08wjgS5jP
fPIvQxg124UL0r4gd9DbIaNkWChc+KBRQw8E/RuOb1yIi2g2Hq3s2AOSEZAHTr0OlxiCK+aC
K/zRB3hCkOSJxP9bKlGWzge+KTS/ZXdAyBrx5xMu6P+wA7G8LD0uk6a4lTGABYQyDp9wmml3
fJFN/o+xa+luHMfV+/srfGZVfc7UHT0s2V7MgpZkmx3JVonyI7XxSSXulE8nca7jTFfm11+C
1AMg6cwsKmV9oCg+QBIgAdBAmq0hAikbGiLuiJyX+GmRUFpnWEzcaIAgCkYceAFT4i/8ituZ
ATZhv74dHw6DtZh223ewQXg4PEDQntNZUZaHy1+n858D9nD3CpZx1pbkNseGa1suGRXMnbfY
URTSdIt3Wkj+ukLDJy+gHhrqPUBOrx8gVNm8lZe1SRUAi/8iXZJVtTLZIaq+TBrfoKVUPztK
BKi1UdDg8lumQz2tb4FlC0xqJ0ekolVJQY/2AZkVeA8MELswgKbTuftDiVQbV26SIfqYpEpw
RFU2f4hl9XNvGPdxhbBfbuBMsB9h0bA913zGmFzhrnCUJWzJVUZ2KaPbjgoxu6/Di0wsHDBs
vkBBHTm1JGtvb8tnPENiPSlqlnJ2lf0rRicbQtPz8hWiQIKcfNhPfFSAqt1SnV1pQHyYn2z9
AEtsOF3N8ft+EPk4nR/sSK39MX2m8i3O9/ttyq4UTYkj2RJL9JLhx17g+/vFFhl2bI8F28m/
58PT4e1tMD2f7h5+QBSH/uBVHwy+3P14opPe5TR4OxyaHIBgiUlbPMUt0hyNOHiSHbe1EXo2
rVA91ig2qwyALGsK2QXo9FECnD7BCWV/mp+zcqqUNbSGBhEsOkh+ybIM2lAOq1Z3d9Fm7CbL
6SYP2Or1jd4bTFvH2zV2LAHT/MkYLJ9RN+vj1qtgYxAQRN2h/3I/F2gk6tBs1WpN9qebgG0w
jvpGyjbEV1k+3xBArgKc5dpdBkvnYJjdeGr3PbK1dqLAUNrEqnASoyNm4Adzq0F2m8bB/hHV
U4o8+a0uhz7sDBJ72SXan3zYT1esSsE2CZ3MBEnjB2xgygF3Q98v1t2BdfH+dDm+Ph1+yY6F
jydgrugqgdTQp0pPgSzzPFvOMytTQ4/pUf1BA87rZBh6sU0oEzaJhv41wi8HgS+TusopIc2u
koAg9WUp7qeU0Jhm0wBEQBAF4RYF1eupgeQMmx91UGMwYBYPjiDo1myPQ6w3xLTE4nkh6APh
By3xCT64P71czqenJ3QaruCnI9gl9H0LGQCXYCkVRy8o+5VU2wOXos3EZhRIneTKd/ZGxRUg
ubakPCVRsxClYaDuQ01kydP5zTRWkMK3LMbp/k9HIepy70fjsQ5NhOYCqQbGQ48qHS1/fGBA
/uqB1mzdIuiecmYggX2RlEEovHH/LagdcdBrADD2oftVOmvVGiRxc8ZKMTm5jEJvh+cQwAeH
X69yVSSrm0rP0jKSzUPL1eTiudBgZ6BqIIY2OhtHIxOtS54EY3VQqWecWXq1eMrXbc82mP8U
JLUfvB+JQBVIgmhBmghxPLExPEZNOa6ETQigo6I3nS4F8/2U1XLdQTyjnCGMF5pE+1QEI2zl
1OJytVvts01oU8QUTSwwEmFjh4DtSSYB29en34IR2Vs2CHT5MIlpvV/L6ssagU0b0iOadLL/
/ZE39OwcGkpgl11SxhO8K90S8nI8CkY2TpeNPhtVa2zg0WRTJ2GMBdKWoF3ElZqw84cxPghv
k8h6D/1od4Uw8dyEIHKUGgijMHISorErK7mIhMOR3ZRztp5nUK1gMnRUq6onwwh9p90kNoF9
pgJ2LEGoAuZczWZNSLFC9J7pbWJs69ticDSqQgfCGbaw6a3n33wF9jtZud9yQUL/uBKqwFTK
G8dpHuV6Renq6nD6v36lmTq0p4zT/ah9i5bJrqRZOQcZtnDVHze5L76bbpSVSKuzKvtmHwP0
PbzOGXYMZUnJB1JqDYfebnD5eTg/3z3ZSs032DwFIUJOXUUJZzhYz8VzncVbKvRgusI7Cg1i
yC4dvFxt2a0U1R0kHTBJWwtZ4dG6VO0ap5W9u8v9z4fTo+1X2MpGq1ndl/LZCYOzH4gjpFTf
Oa9AOLPfLbLlngX+fpuiowqQ/FFSWrjyfIBYgqf3y2B+kuV7OVGd0ioG8AEeOK4kmL3BA9fB
0//ptZIt8ZHylYJo/16ry81URmZVNgdmxPzbQeYK2xP0tvtmldcMaxB9AggEs2bqkFusiQTZ
p+lsVz5NxZJ6PI4jJymNwsnYRUnZJMBWVQbFd1FmbBmFUeT8El3bepyLfBJ6zlckKQ5GPnPR
8jKcjJyFUJTATZHL7u4axV1sWGPlInaNFI9iFwnW3Wh8jTSOh84MFSl2trkSJSJnrRRpFDpJ
dRy6e6qcrb9nvuf8VrkZjz13MRRpfJ00cZO2hQvuJmMXsS5F5Mehs8aSFgehu4RAi7zA2Rya
NnJygKL57u9tGsVZO3Cf715/Hu8tPUwuQIMv7P3heBokp7K1z/7NCuevExfpID/+ON+dPwZn
OVkeX2iU++Rq6Ka0KmA/ttl7sSypZ+e758Pgx/sff7g8+rH1UrcXnaUce3tPW1dZgi1XNZ/d
4olagmnqDrkvSWpl22RgX6HvEXDM2fAp+W/G8xycgFHRNCFZlbcQT90i8EJOmdOckxjVDa3K
5Pwsp9Zc7PlS+Wy6vwxO2s4vA8H5ZSBc+7KyVUwheFINj+ulCk2dXgsHD7WWMgOfL+Xqn3K8
06rarl70OGlVPm8I19pdFq2WgoWdyKg5ceyFrsxmWQVu4krRxjmKzZxds+iX5IIlcNAm3N8C
27ScRryHd+BkTu8wCUKoea5aF0fyJRz98+78oD1ATOkHWh34jXaZn/oh0QmBe6bFfr6rhxGe
/STerLcEKzqrEIyqcyqxyDLKOWy92t/4xPcHoZ4T9Wl5hSyvRxSjpv32eZI67vFIwFqZCWFZ
XQCllLMXRPxyZed+q6c3orCLRGZzBBdjqbTttzk2Fe3JLC2lDOJdJY2cpLwI49BjV0kTJ6Uc
R9HOWSsig6A3NlHgjfLSRZumse/uElYlu2S5xFOBHCsQz9o15+QrvJEJT2DvDvuvksGcBJkZ
dtlGlCRf10GAfK5pUBKQV2UH4wjm4GO2WiScThCIvkVLQ5EVAsJ92wjdAS2UF7G4HO//dLgS
t6+slyrkdJWBfIqOtIScNK2oB6JDrC8oF6qk28y1FaBltjVOTOFJszoaGR0GRtViYVCmFfTt
Eo7zF1sVIGaudDPtSZ2ldkXVa4zVfoClH42KMB5GzEAl5xKDyhaM8R5SB06wxKpQysU6oZR5
h0MHGFlZlnJs7KzT5o4W+C4wdICxnfU48uzX6bBXoNo2jcx6Naix29uR4tB6Ac9ECulVMaNX
02DsWeWtw2hi1qxOGMiIJpon0cTfmQWAnox+GeBNnQay1wyUi9Cf5aE/MfNoCPog2eAyZZHy
4+n48ucX/zd1TFvNp4ou55d32DMeCLhT6e5psOAdaw6+yAd1Vj/HPmi6IeC03Ww1FRYafbw+
Hx8fbR5vbO3M8dWa4BnHHITW3nTgpkIsGXeei4xV9TRj197s5Qs3ndzgRCjKdp44OhCyY4y1
pHZbQQ0f1WbH1wscsL8NLrrh+t5ZHi5/HMGDdaAvNBp8gfa93J0fDxeza7p2lKK94CQyBa0T
K4hnCyEaWxOEpo+y+xd1jGA+5bmOiKhNzAs2Xc/QDV3tCgPWWuDMgRadreGmz9a7lIuShBmA
vVspjPRfXaTD4QirkGvc0ms4PkmrDQggxPNbhcW1jO4BhcOZbLnuFqXj/fn0dvrjMlh8vB7O
XzeDx/eDXDl6da2Pd6qCNMG1XHDNgctTtGbU15FXKWt7nZ9TBiFfL6f70xOORVdRz4mKGPry
SpkLP+McVaQ91lZA5Wu1v0qn/ZzkqiVFFsFKWi4VAWNfVQZKVmz+8scZ3LC/ag8E00JWO27y
6qrtrGzu+nYvU7SNkJ5eHp8cTrvpajnHvJKBPY7GEP/VHJQRE6+zGwiAYMErXoRBGFgEyb4Z
TGsWoWCx51nonFeS5e3ESRn4gZ18BVdxZPmN1CYdFQg8D2WlFZbP2q/E5//lrrlRrm+nZVLu
se+ofJ5BLMnkRmqWELKesKOm8hVE5be8+zRRgAJjocsZvQZCoysROFAV0DddWfgytyAVFw5f
lrEC46++NvrZ3BPtUD2vqntJ4MqEm+k/A284/iRZwXY4pWckVaETrDmjIYL3l1UyFeTFBEtW
NWEWKK4taCQHBBYJAmxf+3CZ5CO8KYdgHKABw7ETxjJkD499uzgKdmYy9scOuAhdRWFFmcv2
5CtZZajhlQRlEoTx5/Q4dNLlXD727Eop2K5UyhInKvy4sJtX4t7Y+VX1hgt1lQUSX8Hjoas4
tRQ8HaWRsIMHFGw3vIIjNzxywlhnaOFCzp7M5uJZHjk4hoF5BF/5wd7mD6BxLpU3R7MlsRQB
5uQUuxmLZRK7eCr95gdTC16Csz8cPUV2Uzc0+xOKUDi+3RL82B7xkpazaZk4WUOOBGa/ItGU
OUdZ4fq6hNeuBgFD+2+hhYvIMdzHQWS3nQRtpgBw76jKjf6fOKM4xvVnY9o9pq62qItQkzOg
OifF0c9NSKZ9kmCvBkqrb/hV2jbrHC45X8GFZo/Hl0dTyGH394enw/n0fLhg9OXu6fQIxrEP
x8fjRapVUmyXrznStAl+HL8+HM+HexXskaRuhYS0HoV4pDRAY46i5dG717t7mR3clnLt493b
IzIo1HNAnkfDuBPPVNHkfzpD8fFy+Xl4O3aVaQmPH1Jmvj+9Sknu8PJ26mvbuULIWn/8+3D+
+4A/vx4eVEkTZ/GkSh12yuTx8ecFZdlKciIPfo1+tamYbLx/HQZg4fb4MVA9Aj3GE5xtNhrj
IdAAuBGrw9vpCZTmT7uv1W0HX4E1Xh5kZ6rYQ1r0fT3c/fn+Cq/JvGRjvB4O9z+REqT1AW3S
3lkevDycT8cHVFjjmqCcKADwpMxgS3arrjLwpeQSjWJCF1k+o7IIxKSoMiIbNpA2kYPrn6Ta
uMn03ULo6zqV0irBKWifVdUSS3NzsYfoSnBig4asHkziJsPO6eslCOxCCkTo9Sq7JSahDbBv
gyEbMHyH2IC2BEOP72BskNCDOj6ATTHN1xqYWKu34EbdY71yJJ9WPJ2bXnEtke4NtCixLutK
s3VUtHEEVcwDezrl6S91WPcEM9SHuoYRIvd/TWz9YbFtLzZuuS9Rpp/i9H4m+kZ/0wi42+xL
7jqAKxjPp9gpl0vVdI2OGf4HR6xWxEF593hQux0owlwz/J5PlwMEpjLn2ur1+e3Rrovaswbf
qfZDshIvD+DNgA4uNWGVDL4IdZXjYPWiTLN/G3SXiRuRrtiznJ4lLE6JWRDlIHF/enbRjv9b
7Fz4t/e7J/mK+U4fZ2q93EHkIGeYQ1lw7UCi3tjB3TC/jIyalGXR2jx1GzH60WVG01pHKQMt
Dhcs7aUykxUkFilOhC8hcieAUSPY5grZFSIFv80EzDzdotOU3Nqg7yu5NyKcSMUx6W25sl8X
OQNfNXTSiZWV1u9kDmgIdHw2oJxxwxDLSw1e1WA8wSxcFFGE5fkGhnMUmr++BBeNIWL5r3yf
aeDtHtsnU1dSdfBgmfMA/WbGZyoVhZsNvj7IN6Hqn3jhQO/QYrVfFerK7TZJgJOIrXVq2MBt
8ucrEla3cu/ycIg6ogEM89yC+XiTcFokUuxRW5a5GzViR7IAv54yYgeTFqxKsceFBiYGgM2f
VPNUK7HPkuZ7ZuhE1Qx1QwzZjosrNHBuMOg3O5FOjEdaoZtd8vuN7/lIYSiSMMB7AEXBRsQ+
tgGMqAkSJEZGEhgPsQgpgUkU+WZwBo2aAC7PLhl62JJLAjHRUUR9Mw6x5gTAlEWdTfx/EMB7
GTeY+JiDRhN8rpItN1m+KrPODronLXZk74UvWbDbwVSCxKo6CYbYtEwB48gAJkjzBnOvMA4J
MInxh4qkDIcBqvmSrUdkV0NZQ21gUjPP5nqjVU4K2uMbgotUzY3qniUq3tSgcCfe2E8MTEjO
irpOeH59kisrWgSTn4fn4z0oEKYoz+pc+cg38U+RAJkIssPB2TfKT5vv40l35LU4PjR5K6Ut
kQuuMpZCw6cQXYxVJPRLYbR90fWSqI2X3LSmZLqu/RWVREWSPHmnudPNkpEXE/0kCsdETYuG
Q6IERtEkqFQ4TAMNcYgyCIpLIv6lYjjE+yhFHITYak1yXuRT1ozGAeXE4SjoOhua++H9+bkN
Bk7bT4fgzTZwASFtPC12GAGPTMq+uw79WoJucWxsfQ7/9354uf/oNNV/g6qWpuIfZZ533KhE
3nnrEfWPLioSMrArf969Hb7mMuHhYZCfTq+DLzKH3wZ/dF94Q1/4b9ThbsmZ+8SMRT0bU2y5
Dj2spDeAkwfnt9XqynKhSI7VgtfzUO/V6MFzuHu6/ERjs0XPl0GlosOeXo4XOmxn2XDoDQmb
hB6xB22QoPvK+/Px4Xj5sJuEFUGItyfTRY1H/iJNZMY4IHItAsyR+pk2zqJe4ySCj8jKAs9B
1wBccsIFDsGfD3dv72cdB/dd1pn0Gzf6jVv9dlPsYrI4bKDnYtVzRKrDBEeX5qKIU7G7huP5
68oOCUt/T/eCyCwsl+Mcm0KpSNPEUU3Hnia1XPijyHjG01JShIE/9imApxP5HGLrD/kc446A
Z+KCNC8DVsq+YZ6HpNRuElaBtvGZA6UEiKIQH7uB/y6YH2DxoSorj1qs1BUxQZFMLPkct9Gq
rGWboSSlzDPwKCa47w+p3BKGWBqUnbnecBFEDoiyRJ2IcIj39BWA7dNJqHEsRChgTIFhFKJy
rkXkjwOk9G2SZU7ru8mKPPawdd0mj4lo/V02iWwBv2XJ4u7x5XDRcruDM2+kvoQXOnjG0vyN
N5lgvm1k9ILNl07QmDrZXHI9kU6TMAqGhiQuav2ue95sszXJbUsviiQaD8OrBDxAkV/4myGQ
9M7j/OVeqvZWk3264YhyWlTKdgZpUIioToirdVm7yTXsmqlbDpxkfUm2oZq1y9zr6SJnyqOl
oqVwxkUUjZLyXV3meGkw85P1xFNvXpQT3+vXq/J8eINp2sFc09KLvWKOGaUMqB4Iz8ZaUZLC
lrmPVyP9bC7QeUgTiYiK6+rZeEli4chiNn1FqhM1ZoJoiMu5KAMvRuTvJZMzb2wB1mrxApvj
BpOV59Ov4zOszir8x/FNnyVYDZzzlFXKYGK/wfPoDE4NsDYiqhkWD8RuQsylgTxuS1Ufnl9B
FHN2aZHvJl5MJsCi9LDurZ5Ru9aSZ/FkrJ7xJAebqh/owfQFB0gZDI57Kbf6pi+gsiM6mB7n
rCr2c56oLfpl9U8fbaU2lI2cIGqXwbv2w05wUNLuZU1j9WI0cZrSN/Sd1MTcF1brBNOsyrnb
+l8n4MXOfbmzJucQ6e7bZwnKBILYfJKiyMSVq4o0veQQSHoh9YrrabQO8FkC2Fb9hP79dvlZ
LSCKMdtPy8LlKzjDUdHlg4r5QizjAJRz5oYTdwAJqpDJVhQLoPTxRfSAXNwOxPuPN7Vp3XNb
F0JhYXrkJ+TOPyauny5ByGDssdMA+ylfws2KvEyu0tqgyH/7cQTzxL///Kv58a+XB/3rb9dz
7Q+lejddhkOBqoAzSB6iD6auCJBYravGd5FEA0Y0hwUonFZhuVjd8VFCGY0tK0jYHOUYYJXN
Od5igeucXPgMRxiZwQUR6oY7YwsYERY4FMpMXYxArh1TQcDzbNcvxjjwjG1Ev4bNqfloEuA7
z6wAM2Uh5Vp8mwFfIe0Dnvb2wZXIOY3lYkW65cs5vYwKwKzF8PkwLEmWyaK2WsOStrJiSzlD
CzyESaJPRoIaX92zm1Vo7ocn2XUzeiO8QlXYGPJaa+WMIbGeQiBpntwarxdczh91ZqDg2sHB
qUEYBDk6SAxGaCcSrr0B7Hw5aXTexF9UQcMx2l7Y3YZ+wrQZn8JklaniCTsz2GxRwQwoTeXk
uv2po22yarrCnv8dRblP4DkIImIuS/N5ny4SG4QDYButWGWEKeYlN5qUl3N13k2iKGkCBPde
4qOBLr0riz4yO2ktVTkH9Gk7lrwQxX7ju0AUxVrcwh1kqxtuxqSHyOqcFnKduuszW60toK+7
oFy1Z8i1RQGZKG2kGz+UYnK0AhWvmwVTFCeoRxL4+injA2pDaab4PIP/r+zKmuO4kfRfYfBp
J2JtiYfa1Ebooc7uctfFOrpJvVTQcttiWCQVJDU7/veLxFGVmUg0vRGeofr7sgAUgAISQCIz
JnftNElHCVOKpJVgqE4B1m7IfBgg1cfAbhaNCpC0+ud6/hIFKi7Iut+iySjje5XFvsFhjWZq
QwLLLHAfwG/jMhLwXbbG/iBnvN4JYJ9EJXRugSqlTHdZ3QjwbYa73QwXpdJam0IqTZrIb5Wk
awGNY7w7bk2BuwzfoHOoe+bT6fPh8ekUJ1WlH/oCm/W3O+x+Tf2yAy2s43IqZ4dA5nUOCIg/
W+n5QSlGKf0aV97nuPK/x1X4g1z5XyRkWYF3WwoVuC+YR4Pf7SqAvvnlrt74dFdHv13M6to0
NffZOHShr0MGR430xeAj06pLWXPU4FxtqlUmw22bMdIrNIBkttAIGXEdIj98ZI6AIo4xBATl
sD/lzOAbCfozjMknW6+mcm9LKHAb8J2LJyD11TNf//um01Fbq6jb0rkKHMqZuT+/9R9Rixp9
CUzpIVVbMFf03Pv0DAkjqlHZ0VPz0dzzAV2p4p4VvJQl/dVSLvzbg0/lUVWUt27dIDxrBbjC
QlOGs/5BSt7x12M2ZscEiOFbnesg7ODpc0vQUvsfogfGFub3vZYsICnjalTMYGItjym/X2AW
IgX1AQ5C6OUhkh8UEtLzWOSxussFeN3BWdKwQdcMjZp8klZmqOaIiD4ZAo8oPQN21gLFiMA8
KwpUeI79pRNmQ45fCFV0SYCRIg9hXvWEuGj0FSBZoK+rUIGot3f6VFRnIaoIPTR47z4IXyeG
5/4QoI1niWOfFoSEVk+QlqojmqD6reSzFA9MFg70nYWSesLCej0IKKF7AMwrBzDe7oDx+gXM
q1kAuywtqM+TpXrUGkWV8OaWPGRnHx8ya1cB98adfADzuQ2OKg5YlQ0RRbqB/q7HilgeAJYw
GaUs7X2dCRjtFFNPuz6+ITf/HRoXOoQ4zQ/GyYwVnY3Ng41KTl8v6q/Z60HdszeM2FNN/Cuo
nATjU4WGGq/ysl8zXjkG81pqcC6SCebXSY6vZ1jAb/Z0bMU2D+H5PpVxlbiPmwY23hi9rBdO
6s83c9819rf2lvaXp4ff7h8PLnrwi6Q63AxmEhRT1aPXEbrPBp6nufIdyspG1AOLefHDXES0
cX8/Vm9IOR3tuNTxt0BSbtI/LvhG0dM+aY9LbMo3+LcLUaRlxhwRSGLESY0oQD5wQeBIUeg3
LTyrMDrMSDL5m0Wo86AOiYQarjMKQrAnmfVvlPrYzLFIDdkbBRr4FCPJdMTWXBL5R11SrfWr
vn9TRi0/dbBS/tE+gFfLI+MDRGyP0rTT60s5EyMUt/lRPlmrJV+oQ1gRHpRWklHrAOI3QpSp
a/CKFqqVRcosDN+UYhOfLHWkqRahYx3VSrXjUV6rZEcFst3bVX1koDICWVIf5/vjz8NE+3a9
hdXYReR4+wjHEr5IF5EIBqLM7nhvoeGeJIGsXpMAm4LIm/VBgv6I/Bt9zGyokL0sQarOQyv3
WaTpj3/Ozb5+o+HsodNRkc1tH1i+LzLb4c2xh2uKvsTx0d/KZFEZUjqcRPLW2KMXPkcFGnpi
KIkMJLBZQELvwr4h1ZHYv4LI0dnDihTV8cKM2JgSApWRvVD9W4eyQaFQLGrWIlPRevIzQ74I
SrIt23Ze9EgJWpx+QJQ7lh5w4VSBrYW3njP130FTQaKGcMBH0jxGHOPCr6jIIicaiWXLoh+8
JsWDpf5pjhf+phjzgWJAtV6BBuw/nZ1buyU19KKQwc7b0Mm3p7vfT367+3b3+EVbg3lWTTo5
s90wsDPYmRjTABGZKUzkgkS0kXG727G8zovSqWDd9cyL23W84vY+VCaekA/lDUeaXe6lFPsP
AuZlmW440vsIXlAYqL52+qR+7X4TfnPVx+amv0LP3H3//u3+i97fPvl6+Pbdf5Js8dh882Tw
miKzO0Q27f/5B9voEDMh7yJ9eIDM9+gWJKfMCO7jbsuI4bCgjYranal5rNu/8AjYW/BRvT0R
yBq260PbCvwRKXW9pc4TAcwTDBTa7N0FKkDiNAi7SGPWRalUPUCKtaZWanJysLELl44KfwtR
3vfWDN/yBZBuTKtupvCi5buFBrdLpY2ME3UaE107n/8I7DCUnJDF5/Ur3R8jpL/1aWiylidP
LA0TEOCrfFYYvph2r0ZdjJGH7BqwCCUqVKRb5Pp1RTwiGEitqceO+EQ0uOr1crtGoRZSxPIq
dsz59+r/O+qsSKcjow6lllGH4suos/okfHTzqLPi34/7gBlhxwWG2lGHZk2HF8pJyYQydUMM
Be1wIb6VxAlDCXvWDSVeVdihhJgZrEIf+yr0tSMiGwt8U5Jw0PIBCjZpAtSmDBBQ7k2mXrgL
CFShQkodG9NDgOg7P0Vhd9MygTyCAxZmpRFrJQ8hK+F7X4U++JUw7OF85XEPS9TtvP2dZsnj
4fUffPdKsNZbmmoCimJ+b3n5lLk1L/RRay7gHydZwj8Y0R8VT8pZHeRTFvOebTlFwNnqOPiP
ATV4DUpIUqmIuXp/Pl2ITFQ1eI2KGayIILwIwSsRZ7suiKGLQUR4ew6I6wc5+x3xiEpfo8sg
PJ1EpqEKg7JNMuXPq7h4oQTJVjvC2Sa8mtvoDqMxGEwWs0PT6RVwkiRF+hLq7TahCYTOhaXg
TF4E4NAzQ94lE4msSBjiC1YXc3t4fjx8O9ncfQEbbr+Efj50Ewd+TWm8hnPLBHt0MYQ1xTOG
r9r2CGzv8L2YoFy/ic7EGx7BJ+qmFp34grxfghAL+TJLWpMjMRXt0p78mIgRIwCs5oYCe8SD
X8aLGF2FR/jShPoB4UBbH1GvOhVJRR+Euz0Zla3aJqJI3J2vri4lTLUtt9Gi+7rwa46pTdHd
BX2IDEMaIHGhyTCxJkNZ5Y9r3pdZrNUapodQXSziu2ZhrLHjMKE3EOJMf689CqztgAcGOO8u
XFDNQya2fJgBm9E2q1NZQspdE1mQ2fafZUK96ceL9xcyWQ1bmVA6dFEyU7yZvE5QIXRVQlxs
7Id7xqb1DlvAIaIihJnalxTsVM9vMpR4N0b9wD4Nh6ikoa2nqG3LjMJFm6Yt+zllNblYRaKK
Q9Tw5Ve7aUgxV0qBb/G0ZQE/rLwj6k3iSytQW5PLDOi79MgOsxscjA4TVB/HTNVYd+4iC3VO
dr0xOaZCbmtFZDdKeU07uTjrY0/CGCWVFKcqVw6WoIsCSYKpZEs4dwmb6tL+A3wmdgXUPw4x
iST5eQSivO6h5g6ep5k7Nkv8kOsfhx8HNc++681OIJlyrfSUxNdeEtNmiAUw7xMfJXOIA9sO
X/1yqPFB6+MdM4/QYJ8LRehz4fEhuy4FNM59MIl7H1yL+ae9d8KncfU3E9447Trhha/likg2
zTbz4Wvp7ZIm5RdzAM6vw4zQdBuhMtpCKIMzYvaly3EtvLZRjLCK5XSlXL4xu6hSqvRHJdwr
HhXqaTaMbbUHu5xcvXKcfYVPp9//uP/jafrj7uX11Hn8uXt5AWePvqm30ofYhSoFeDucFh4S
uM164xN6ALn08XzvY+RIzwLaw+JSDIf6FvQ6s37XCkVQ6EoogRpnfFQwGDHvzQxN5iTYebTG
9Y5FVLIem2mY3fmcT1aT7aeLc4FK+PVHi2tbE5Eh1YhwtoxfiEGN9iKRRHWRikzR9uw4Wb94
lLCLrhHYcMORPCsq4OsIrybXkTH3jv0EqqLzxi3Ae3ChLSRctIMPctsxU7SM2wWahAte6Rrd
xrJ4ws0GNUqX5g71+pFOQDLkcXlWjfDqRS68t7mb4t+PVcI6IS8HS/gjtyWCX3XBlXA9Ghf4
4laaoJZMa4gg1TfljgW0ryJwN7qTMPfPHVqIILKMRDyNBhHH0XQQXNG7qjghroxybmEatSjZ
9fsCvu4HAaRHP5jY3ZBOQp7J6gx7jd0Zlan3EbaArq0pPkXVl8JGc0Cmdd9QGV+T1aj6pIRr
szU+rt30XC3QLwKWNiTf8sJd6feoOukLNNbroVgTuodKhHdfWi+A9KV8CFFfIu0zvsY/2hwM
VbKogiAk/eIoz7llfz28vHpKZLsdqNU8rO+6poVIgwX1hhlVXZTqQhuvFXdf/jqA0ziIYiuE
NorI+gl+qZ5cRVNfgutg/HbEP0bX9PM5UHTz8/mHk0db/lCcnGpbYJVn1RLLwLi9ziA+O/4e
b7UzTLidld6I+AbjtxEqXoI7t/pBt8oBiBMqPq337n3Ur6CjYpDceanvbjyoLz2ImH4BkERl
AhYCcFMS72sAR6MeJm6ROvv7WDoU3v+Evews7TA7dTkNTzVD0zDcEsm4zlqamAKmKpn4LpKj
zPmywG5IASccNkr99BZaWiSlz/iuSRA4ZUm6kZke76HBlvM8nBqH4d9+HF6fnl6/Bjsq7K3X
A/FJPNDuon7Dpgr+vUkK6wPew6CrkgEHUZtLEY6TvhWJaNhcbEWGDDgLfGG9sfuMeUc590rE
yUYSLtR6dXMjMlW387LYqf+RatJCGNgX9KZYlKuBtcN7rQ5hZlgLXOuD17LBN0Vnlk2i3c0W
X+1WYtuE+Lmhg7WF4YS4G8klXqjqklxOdQjsaiA00/dNcLtoCG5TMqhvbz2hAnWlJF/DDgVy
rWV2Qs502Cu4je3LwhCifSl30z7qIPpYLwglWTcUeZHoC9xTU4+SUJddj+oVdRQz8GSSrdNY
EBv7TOmGHaiIWgQURSk5HWtsEYGbVaenQqbqR1aWYxmpKaAgd0yJkKp7cPjVTEUn1oJdvkqP
ezrYUi8QgM+L2jzTe9LSZRGz5nGIicZhI9vIHI2Ww0gaLmcmWde2G1jEe6ZBwApy6hJfVIFq
2VNDry+PsxMOAS4K7EISru6PZ+T2PU4f7h9fXp8P36avr6eeYJX1G+F5Op/MsNewOJ0+Wmv3
CAmZjemzLjAlJ+umqNWwlQmUdboTapypKqswqRboQW4zBKkmiYNcEffeWdZMtmFK6eNHODU1
hdnNvvIOHkkLmmCkRyWSPlwTWuBI0Ye0DJOmXe2lUKlrQBtYA+YbHcfw0xyWcF+AqfcD+WkT
LGGY/TTHOuzybYE3Zsxv1k8tSL16gbL/seW/vZCLUZFj9bLIJQl4mOmhChx7HEIsazcTDSpm
ETgGUzojT9axMMyT9fayesiJbSJEJlsXA/bEB2CNFQMLTFSrAnTDxfpNWibLMuru+SS/P3z7
XXuP//HojG3/S4n+yyp9+P4XJFBUNMU8bT2Aev4EsK0/4ADdMyRKXlwIkC9ZFUmnNAN67xnB
whNEfXKIUG8a9h7vh/Mz9TeSUUnebyeD+bL1TSs0qgGFlC/yfVd/EEEq3Ur7b2RjyneX4hC9
D7ZsD6mi6wi8C6SW+Fq9YJsW6qOhWmkV3ZoePxO6/41VOS/lU97ZFKnvMvzNgEmvfQd8rOkY
VWoR78tCQNMoq5rax3dYEXQg24JycJsE8utmo//8HiKpaUeY6O103NoKP6yUoXMS38wC0000
DJ0nN7VNX9xMUVL61GzXhpkLnvhFOJWLYCqXPJXLcCqXR1LJaq2bFbgB3CNBjg2mv8Yp2kOH
X1xCJVbFps8uc0lWqMWJYvCLzCCLHjfjsN5gTq9QQryNMCXUDab9+vmVle1XOZFfgw/zatJh
kCXXjTQf+G1uyxERIWuAsUYPvxut0U190o0xZVhxAIp69f7DlEfk5FnpmvQLsICL7TylJVps
gzcdKu6QqTnHkaVmeA7j5d8mnmWYE0mDW2U26rdgDyeSZA964N3LIVJlzpzuenqrYU3bdJbo
xhqczChSL1m9LFlNG9DUtZRaloO6TX1ZFSWv1fycvYwGoJ7IS1sx/iU4WHhxR/mdWDOmOqQs
pPHBcHqhZDY0KNtTX72hIQsWqjhHh0wxdMGpwevfvCgzP+q4dmMzNN1tgKfFX+q0r5uBtETK
gcIAxo/rkl7E5Ryio231OpRZVfS9yg4Vnn3n+ud8JqFd7usLf7NA2ynQitmNEP4063wGpN5n
rvNqAFehDMBRoOCpZECNEo1Dk/d02slBl8BAMuIwQo3q1aXSOMjYMGOzjeyU4r0OSSAq99Et
XKcr4RRaEjUnbxJT63jwOJBkcke9KeQ9m5kswMcgB2/UAN6su6jyKW/aM3ATm629AqsumoLO
ietvxvx10Mzg/M0LpT91TfUu3aVayfF0nKJvPq5W7+lk1pQFVuo+KyH8xY1pTuThd13OO9Jp
079Ts8a7epCzzM2otCievXqCIDsuAr+xDUgbrbNPlxe/SHzRgJ9zOFQ/vX95urr68PGns1NJ
cBzyKzSqDmwI1QCraY11e/em7cvhx+9PJ39Ib6mVEeLyH4At3SbVWH/bk69Jg/CG82EYpZJN
UaZdhoZO2IvEWbFgA0PVej+lsdUQbnKYrWY241oNOrEukmA2Y/6wyqvAr6XukrdqEq/wbK2d
OTDxKJUBU9cOy5lQZrYORchuf1HzWva8+t0qJSOAiXoAL7gG+JTOi+npinz6dohN6b2Ha5/+
PEjnwirG0xIM249VFXUe7OsAMy5qsU7xElRZoMCFBxiA6Z11PWv2XOQzsfg3WPm54ZCOMuOB
Y1zUuEfaXLVz1oBFPRaBM29bbDEJ2AET7cWwUB7tmrFTRRYyU+VjbeyQxSu6riM0hjoBUgkz
SqvLwBHUjb9VPz8jqVwz6TddomYJMj/r30aLIsd7lqgGdKjUX49Rv8GPO8ToVG4PYrkRQWgz
d0sXIZxYmkGFqabRF8WkhKyEtg+VL2FIkqBqJe14LGv2Zcw4bZMZLj9fimgjoDefpXR7qWan
yy1sxcTl1uzQ+gJZFWcp8f24VLK12Z6ssgIJXMyzK19UVgWENCCaWMWHypYB1/XNpQ+tZIgf
UHrJGwSipUOA4FvTCXGrcwHVGeXQKjyhZthIUXC0mBqtXEZuflXaE7YwMr91y8+DHC6W5VVj
z7RYrFnuUpSjUokNNcJKNbVVjypRTaw7OuTwIch8+HrqQAOC3xzZTcNnLI1w2ywWp0D7Uxan
+JprUuo3XkDo3xf8N51zNHZJZfp91HKJ6cxDkL/ptnYjjtL4iTtWzZjWp1heZjfiEy6/SccF
0hb5+ii5SKe0qSI1Q53+pW+q/fz0/Oep95QJq0EGZ8u5oXnibq51NbLd3Nrskdi7P3A8QTmu
sOY92XnvU9USXk2n5HaUBSSpSwa0RO3UkK5TW3eU6ZO+EAlX5SJ5vILS8H7CGhz0wXBfYLNP
Pbuxn/y94M3neZa0v/VivXyEY03sOMzvaY0NwywGY5JamNBNfMvRjq0Q9caQyLTt4g9eStJx
FZnIDcA6jkUl/S4pyOOFv8W2YOcM3GfRdmr3xjErpcY2iUqWDZ9cNaaLxDCvgN5rzxgvkrUr
G9WUz+wyNBsqWV/FEMyUgn41NmlEVyp85eIXNZIS+tiSx/RPSURqMEP4Kl2N4xDV+oTYWhz4
K2Gg3VJ6usRBAwnzS5jBITUJc4XDuTLmPMiEUwuV4GoVzGd1FmSCJcBxTRlzGWSCpV6tgszH
APPxIvTMx2CNfrwIvc/Hy1A+V7+w9yn6BnrHdBV44Ow8mL+iWFVHfVIUcvpnMnwuwxcyHCj7
BxleyfAvMvwxUO5AUc4CZTljhdk2xdXUCdhIMbjbrVRTctvBwklWUneBM14P2dg1AtM1St8Q
07rtINiNkNo6ymS8y7KtDxeqVFGdCkQ9kusd+N3EIg1jty2Ia2+4ngQbdDOSYueO6gf1FNAf
vvx4huCiXog3OgcofaAvlL5a62BnHTUWjD1xu6ZWiwmKQ6C0FBy+ZEapw5tvTltJq6zXwR6H
rsC3efxxe34ElHXtj2fTNFshzVzKx+riYYaFpJtpGlOt7KupAr+MajmoXQZ/Wn34cDG7fNR3
03UASbCMhAOOpGlvJzWPNklENik9oSOUUt/KElSjYzIw0PRgX728AujeiZaAzRnrhvY4bV73
9N3Lb/eP7368HJ4fnn4//GRc1p16ddOrD6Eeb4Ras4yJEReRrf6wzLSLyjH7dBaUTIteu4gP
p2WtXI9IRLuEK26ejD6x67JrsHS3hXrvC1ekRSgOTgzq9SgWpLKRO7gFPZOIWnA+oK1so1Iq
7dBUzW0TJLTdGhydtYP6Qofu9tP5+8uro8Lgtl77UDl7f34ZkmwqJbScQEO4BvEtVPkj1bOO
Uf+g6WdRqjvLPLo0G5RjamdAwB42S9XOBK0FqSQJVdMWdZhR7QL9ORUkbqMKHWsKZ+kzZHqI
mhsyiYz626rKYHBlg/MiMnRgQ5C6oV5MRQc0WAhStipSlRD1I+y+JJ1a6t+o/oNZGDSd1fy8
2wPEkFVtGQ3S1jTQ9XqW4E+qd37r6Tl8nEvi9P7h7qfHZdcBC+neYz3GkIy4wPmH1Rv56Y56
+vL17ozkZCIO8yClwGgLP4lQPa2LChK4E6HS2KorNdicinTTuTlMH5wNP2wCjmo4Ul1SdWzV
CZs6JSci8GxcqmFJe8oVk4Y+Pd18eP+RwoC4WeXw+uXdX4e/X979B0DVHD/jSMXk5WzBihr3
u2xXkR8TrJPVKm8c8Z08IMylAjOQ6tV0T3mhsACHC3v49wMp7HxL3p8L/Zv0ZGA/fumeDrb/
TNaNSP9MOo2SI/f6Z73r9OXw7f7xx3/mN76B8Rq2gvA6Xhtw02DNBquyKmlvOXqDLy0aqL3m
iOoA6QrckDfYYhk0zPl+Y/L89/fXp5MvEEfu6dlzqWuEIXZw1OIbnhg+9/EM3whCoC8al9uk
aDd43uOM/xDb/VlAX7QjFwNnTBT0Jz1X9GBJolDpt23rS29xRGqXAuzQC8XBro8slvovre/x
saYFgyM1j/plsrifGY0DTaWdqsjNy6zUOj87v6rG0iPqsZRBP3tYNJi4LZzRf1K/aAE8GoeN
WkJ5+GAc6pjbtj9evx4eX8Gs/fD7Sfb4BT4AMHD/3/vXryfRy8vTl3tNpXevd96HkJBrr7YK
8H0/J7eJ1H/n79VkdHt28f6D91CfXZOLaK45wV9psXOFjb89ffkLgjJhIyGXRZz42Q5+qydD
7+WeYWNIi5Xd3sNayISDN0KCah7bd9HsTntz9/I1VGzixd59uyQEp8tHynxnHjeWP/d/Hl5e
/Ry65OLcf1LDEjqcvU+L3O/Z4igTbNAqvRSwD/5HWKg2zkr468l3Vaq+JhHGe48LrHQoCb44
96WpE78FhCQE+MOZX1cKvvDByseGdXf20X9+35pUzcRz//0rvRrupgl/kFHYhIPeIvjmajWt
/JqP6jEu/G4adYkvq6bifU52gxjhRRN1fSeqsrIsIoHoh/BD/eD3HkD9pkwz/xVy/df/ADfR
58gfEXu14I2k3mDwUPW54UsYtjIhk6xrice2edj1q2bYN2JdWzxUa46ey2uj3z58fz68vBAP
SHPd5SWJi+KGOWwpYbGrS7+zgp2FgG3m0ae7e/z96eGk/vHw2+H5ZH14PHCfpnNf7IspaTvs
m8MVsov5jUjMiMOiYaSxSTPSFACEB/5aDEPWwX4G2TNDKsEEOh8vsiNYbETO9k4xCkpI9TGT
USZ0ZhMfhVy4cMwerxbmHgAWC6X6tqJqbguVtvqqJL2dru8nGiEbke0Yl1YGQlgTMb3qWa5+
Z96193ab9L/Md2VlVrthIL6A7BKuzYxxgba9s1fLZz3+8Pxq3IEdXk7+UJr8y/2fj3evP5Ra
/+XrgbmyrZp0LPXKUOdz+kU9/PIOnlBik1qq/fz98LBsUmqDi/Bq2Od7dO/csmYZiarGe96T
MHZEl+8/zpvC83L6zcIcWWF7ErpbaYPopdRxUUM22sY9d3Vc3v/2fPf898nz04/X+0es25iF
Fl6AxcXQZaqherLhone11SS0QbzQFcGFEHQ1uDg2DgXes3RUXtSp+r+u1/GN8AeRgD/kgYzG
yRmZW5LJV3mSqRjGiT51QVR19XNxKvLAcHAUFt9e0a8QMZfiitqKRN2ebT4xCfWGkiUwm8wT
dMpWFrGvBiZItbq5oeOX2bG1tYtfwxC6zUyEWCck2XlFddpUuJ7m+lNTzGLS9YBRYy5IcW0B
pka6knwoGnXz2nKQgqzBKIpSRvilUA49scm4mArYEAriGpbe5+YzwGic1L9hNvewFjzztb5s
Ea0uPTDCB00LNmzGKvaIXg23frpx8quH0S6+vNC0/lxQN76OiBVxLjLlZ7zFiwhsnEnkmwCO
Xr9TatjUN2VDdCWMwqPoukGMPZyB28A+gy69CCzYtMV+MxAeVyKc9wjX94R2UWlu+aDps2+S
Qk1YevjrInwYuS7NqR56a+zwa11iz4LwSxiF6pLa+ZTdOLGbNEn5GSImoBGt6VK8Bkux36ei
u2ZeyKq2oAa5/lmB4vMUffNNoX26qJmlI8bgvfoPoqFLVsFKCWiakgxAnYmPCZzeHpAeAzeU
adY2+MDGhu5eAB3fD9eentWsv/uvs797jX5/vn98/etE6bgnvz8cXv70D7r13Ggiz+NK1cak
cPSl/TfMW2rz3Rmn+3gS8zEZ7Ma71FOw0kM947aO1MKZnsXDKuD+2+Gn1/sHq+y86HJ/Mfgz
Kjray4UTJ9Alhdo0Z0n6UpsSVJ8faCN4W9zw1dgP/HJw3qk1oX6SnhFCLF31FVRK+8Cmq3Bg
odNS1IKOtdKDUxCNGzz3awsYE0kTjRD8qqlBemOfCDdjmPdSzpj3bOrylr9G2+jP2cus6ZLM
WuIpdR0i0C5fSbQu9BUj9f24jXBTXZ/e/+dMklIKcIFv/Jo8jLsj18LV4eFJ6V3p4bcff/5J
NFldJWosyuqeWGOaVIDlYwslXFt6O786YVUBfUMvNlIcvCOZ27dBic9Z10jZw11bjpvLeV5b
WljQKiifkzGXcjoCeDBlatBBuS4Zpw3Z0Ke8ueHg/L+EpFg9L8fT5Rg7UXy+CzAzLtDKs+0e
VVaVqgN63eYNfFJTVnmrY93YxcX7gCBXAQjpenaTe02oR2K1joUbg4zCR24O0fuZ1AxzprpY
ANu1Uv/WXkOqksEFY3rIN88cWzgAmmH/l2sdreB20HN7JqAdTY36jgcxZbUvvVHzpftY9Vd6
Uj59+evHdzMQb+4e/0QTB5x8jeB/Z1A9g1g1NPkQJBcDByTWqm8v+Scy3CrCpD9tRjgZj3rS
Yezhs6P0pwOG4mfn7/2MFrFgWZgIL8r+Wo3A4G+1IcMMSML9NnLBnMA8IUO60i5mNuBu3zPW
0CDdS9EYN+jRcqZTgw0Nm+5M80OW2yyzsUfMUhnOLebx+uS/Xr7fP8JZxst/nzz8eD3856D+
cXj98vPPP/8LR7yC1MDv4aj0y8yf01QO9AKN7fyy+H5vGDWYgL9MbHxmPUzBBX42P7RdsxPu
6Jtbai0F9AAlJUokrRXM0IDi0peZzzlfFnrfzI7xPctKfQugbLJxaXlFTyUe9H0E9V2y8UK3
pSYXTGsAqiKU5gEbvOCKUK9kvWHUjOYBGBwGZlHvDWX0rrmdAQsRxjeODKIdFxTC1JV0qqD1
UETLTXA1U4k6gm5SRaLVjlibMNOB13oBDj/AqhKg7Nqzybc98toqTx1TmwxtPEqAl8o02+GL
KbYOpqzrmg5dPpkL0uT6lD8sjZZK2oHZW1JhtxlRUfYlXkcBYjQa9ilpooq2mfZzSfQWTRXN
PFhRIocujTFSFkHlhQ2ROrkdsLli3bSmbdAcYn5rCz3WbOZrSejoopdL/Bq0WrOoSdDzcqj+
DNrjqHECznNGSelq2rNLOF56bp9PegW9iuP3cnP2RurLV5Ng7iVgRnSObvaqDkP11ddR22/w
2pIRbh3AXipWo4gOtNLobWu4Oo0Xtg6PatUZYYVlH8gClxqduBqnJEGXaakvsureZWsEJxFn
pgWlR00VCmq2I4ZIjQLtRMmlQ5jhQTtYiIgDNE3q1dQUq466oUEwcN9Y6AeJlktg8s5g2wUM
qqGW/A5j3tq4RlyyVjo73PKG9ECIHkWV23Qgez69i+9ObqqZlyZQ7OYYXZl81Ixhc4iBZOOI
cXaFQUEzoa4uhakPGz+xSRGKuslu4LYWfwGzO2KMt3tGbhU7NDcMtacDFLS7LhTUZnUU6mD/
WVvf8+KRfWlT6VveDPqgTBu7s9xxlAp9RqDKI/UqLZ0XXaXmfl4C6yGE5Wi2Ynilact3feTD
aoxEvzDLO4jxEMG+Wzc6vwHLnph2SSh/+Xods4+g+45xD7G5jCWR6Bqhj4g/AhCPymJd65hi
jKA2SmZtaDaeFPp/wYTYHMw2AQA=

--UlVJffcvxoiEqYs2--
