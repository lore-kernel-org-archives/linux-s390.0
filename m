Return-Path: <linux-doc-owner@vger.kernel.org>
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 3/7] fscrypt: remove filesystem specific build config option
Date: Wed, 12 Dec 2018 11:57:31 +0530
In-Reply-To: <20181212024811.GB722@sol.localdomain>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com> <20181212015211.GA23905@roeck-us.net> <20181212024811.GB722@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-Id: <5001320.eMptl8WvNp@localhost.localdomain>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com, corbet@lwn.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, green.hu@gmail.com, deanbo422@gmail.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com, viro@zeniv.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, December 12, 2018 8:18:12 AM IST Eric Biggers wrote:
> On Tue, Dec 11, 2018 at 05:52:11PM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Dec 04, 2018 at 03:26:46PM +0530, Chandan Rajendra wrote:
> > > In order to have a common code base for fscrypt "post read" processing
> > > for all filesystems which support encryption, this commit removes
> > > filesystem specific build config option (e.g. CONFIG_EXT4_FS_ENCRYPTION)
> > > and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> > > value affects all the filesystems making use of fscrypt.
> > > 
> > > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > 
> > this patch causes a recursive dependency when trying to build ia64 images.
> > 
> > make ARCH=ia64 allnoconfig:
> > 
> > scripts/kconfig/conf  --allnoconfig Kconfig
> > arch/ia64/Kconfig:126:error: recursive dependency detected!
> > arch/ia64/Kconfig:126:	choice <choice> contains symbol IA64_HP_SIM
> > arch/ia64/Kconfig:200:	symbol IA64_HP_SIM is part of choice PM
> > kernel/power/Kconfig:144:	symbol PM is selected by PM_SLEEP
> > kernel/power/Kconfig:104:	symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> > kernel/power/Kconfig:31:	symbol HIBERNATE_CALLBACKS is selected by HIBERNATION
> > kernel/power/Kconfig:34:	symbol HIBERNATION depends on SWAP
> > init/Kconfig:250:	symbol SWAP depends on BLOCK
> > block/Kconfig:5:	symbol BLOCK is selected by UBIFS_FS
> > fs/ubifs/Kconfig:1:	symbol UBIFS_FS depends on MISC_FILESYSTEMS
> > fs/Kconfig:220:	symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> > drivers/acpi/apei/Kconfig:8:	symbol ACPI_APEI depends on ACPI
> > drivers/acpi/Kconfig:9:	symbol ACPI depends on ARCH_SUPPORTS_ACPI
> > drivers/acpi/Kconfig:6:	symbol ARCH_SUPPORTS_ACPI is selected by IA64_HP_SIM
> > arch/ia64/Kconfig:200:	symbol IA64_HP_SIM is part of choice <choice>
> > For a resolution refer to Documentation/kbuild/kconfig-language.txt
> > subsection "Kconfig recursive dependency limitations"
> > 
> > scripts/kconfig/Makefile:69: recipe for target 'allnoconfig' failed
> > 
> > Reverting the patch fixes the problem.
> > 
> 
> Thanks for the report.  Chandan, it appears the problem is UBIFS_FS selecting
> BLOCK.  It's actually not necessary because now the parts of fs/crypto/ that
> depend on BLOCK are separated out into a separate file fs/crypto/bio.c that is
> only compiled with CONFIG_BLOCK.  So how about just removing the selection of
> BLOCK from fs/ubifs/Kconfig:
> 
> 	select BLOCK if FS_ENCRYPTION
> 

Yes, I will do that.

Also, Apologies for sending V4 of the patchset without checking for newer
responses from you.

-- 
chandan
