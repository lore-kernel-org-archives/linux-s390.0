Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 5 Aug 2017 09:50:36 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Re: drivers/s390/char/keyboard.c NULL pointer reference
References: <3b10f99f.aa01.15da8632dec.Coremail.sohu0106@126.com>
 <20170804092608.GB3278@osiris>
 <5ad3af06.c08.15db010eb92.Coremail.sohu0106@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad3af06.c08.15db010eb92.Coremail.sohu0106@126.com>
Message-Id: <20170805075036.GA3376@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sohu0106 <sohu0106@126.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Aug 05, 2017 at 09:44:45AM +0800, sohu0106 wrote:
> 
> 
> I don't understand a bit,My idea is 
> 
> in userland
> 
> fd=open("tty3270",O_RDONLY)
> ...
> ret=ioctl(fd,KDGKBDIACR,NULL)
> ...
> 
> then here 
> drivers/s390/char/keyboard.c
> 477 
> case KDGKBDIACR:
> 	{
> 		struct kbdiacrs __user *a = argp;
> 		struct kbdiacr diacr;
> 		int i;
> 		
> 		//a is NULL,a->kb_cnt will crash
> 		if (put_user(kbd->accent_table_size, &a->kb_cnt))

a->kb_cnt and &a->kb_cnt is not the same...
