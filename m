From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [-next Jan 18] Boot failure on s390 with DEVTMPFS=y
Date: Mon, 18 Jan 2010 15:31:09 +0100
Message-ID: <ac3eb2511001180631r5209dff6s83ecdaee708e0b0b@mail.gmail.com>
References: <20100118195743.b45f119e.sfr@canb.auug.org.au>
	<4B546E7B.2080900@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B546E7B.2080900@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 18, 2010 at 15:21, Sachin Sant <sachinp@in.ibm.com> wrote:
> Today next (next-20100118) failed to boot on a s390 box
> with the following Oops :

> Unable to handle kernel pointer dereference at virtual kernel address
> 0000000000543000

> <00000000001eb5da> shmem_fill_super+0x13a/0x25c
> <0000000000228cfa> get_sb_single+0xbe/0xdc
> <000000000034ffc0> dev_get_sb+0x2c/0x38
> <000000000066c602> devtmpfs_init+0x46/0xc0

> Previous next builds worked fine on the same box. The only difference
> between configs of the two builds was CONFIG_DEVTMPFS. This option was
> enabled while compiling 20100118.

Heiko Carstens posted a simple patch to work around the issue that
s390 write-protects the string, the option parser tries to modify.
When Greg has pick it up, this should be fixed.

Thanks,
Kay
