Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: drivers/s390/char/keyboard.c kernel stack infoleak
References: <116f735.aa23.15da864e94a.Coremail.sohu0106@126.com>
 <0b76e8f9-e1ea-da9e-23f2-92cdbd475ec9@tuxfamily.org>
 <20170804092017.GA3278@osiris>
 <78655e6a.d34.15db01cd5b8.Coremail.sohu0106@126.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <91456a7b-cd05-c832-8af1-6d416adf728a@tuxfamily.org>
Date: Sat, 5 Aug 2017 09:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <78655e6a.d34.15db01cd5b8.Coremail.sohu0106@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sohu0106 <sohu0106@126.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.08.2017 03:57, sohu0106 wrote:
> My idea is 
> 
> struct kbdiacr {
>         unsigned char diacr, base, result;
> };
> 
> sizeof(struct kbdiacr)=4  
> 
> here we just set 3 bytes 
> case KDGKBDIACR:
> {
> struct kbdiacrs __user *a = argp;
> struct kbdiacr diacr;
> int i;
> 
> if (put_user(kbd->accent_table_size, &a->kb_cnt))
> return -EFAULT;
> for (i = 0; i < kbd->accent_table_size; i++) {
> diacr.diacr = kbd->accent_table[i].diacr;
> diacr.base = kbd->accent_table[i].base;
> diacr.result = kbd->accent_table[i].result;
> if (copy_to_user(a->kbdiacr + i, &diacr, sizeof(struct kbdiacr)))
> Is there anything I haven't noticed?

Yes: sizeof(struct kbdiacr) is 3 here.

 Thomas
