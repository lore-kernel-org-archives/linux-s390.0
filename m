Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 Jul 2019 00:05:30 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
References: <cover.1562950641.git.ptesarik@suse.com>
 <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
 <your-ad-here.call-01563114933-ext-9422@work.hours>
 <20190714175041.194c98be@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190714175041.194c98be@ezekiel.suse.cz>
Message-Id: <your-ad-here.call-01563228330-ext-8076@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <PTesarik@suse.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Philipp Rudo <prudo@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Raymund Will <rw@suse.com>

On Sun, Jul 14, 2019 at 03:52:52PM +0000, Petr Tesarik wrote:
> On Sun, 14 Jul 2019 16:35:33 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
> > On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> > > Various tools determine the kernel version from a given binary by
> > > scanning for the Linux banner string. This does not work if the
> > > banner string is compressed, but we can link it once more into the
> > > uncompressed portion of bzImage.
> 
> > But even before discussing solutions I would like to understand the
> > problem first. Which specific tools are you referring to? What are they
> > good for? And how do they get the kernel version from other architectures
> > compressed images?
> 
> The tool I'm aware of is called get_kernel_version. It's built as part
> of openSUSE aaa_base and is used at install time. I'm not quite sure
> how it is used, but I have added Raymund Will to Cc; he can provide
> more information. There's also an open bug for it:
> 
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1139939

Oh, I see, found it, thanks. Very interesting tool.
https://github.com/openSUSE/aaa_base/blob/master/get_kernel_version.c

And the only usage of this tool I found is to get the kernel version of
/boot/image (on s390) to run depmod during
yast-installation/src/clients/network_finish.rb

I also see that queries to rpm are already done from
yast-yast2/library/system/src/modules/Kernel.rb
Wouldn't it be more reliable (and portable) to just get the kernel
version from rpm metadata? Without using unreliable tools? Or find some
other solution, since this is the only use case for the tool?
$ rpm -qf --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' /boot/vmlinuz-5.1.17-300.fc30.x86_64
5.1.17-300.fc30.x86_64
[it looks like openSUSE kernel rpms don't have metadata to reconstruct
full kernel version currently, but that could be improved?]

Anyhow, I'm not opposed to an idea to make it possible to detect the
kernel version from bzImage. But it should be reliable. So, see the
follow on patch I'm sending.
