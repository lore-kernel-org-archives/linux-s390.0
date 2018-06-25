Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 17:09:17 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: s390 qemu boot failure in -next
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
Message-Id: <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 06:35:30AM -0700, Guenter Roeck wrote:
> On 06/25/2018 05:26 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 06/25/2018 10:49 AM, Cornelia Huck wrote:
> > > On Mon, 25 Jun 2018 10:36:33 +0200
> > > Vasily Gorbik <gor@linux.ibm.com> wrote:
> > > 
> > > > This change has been done on purpose. Uncompressed image is not going
> > > > to be bootable any more. In future the decompressor phase would get
> > > > more function (early memory detection as an example) and there is no
> > > > chance to duplicate that code in uncompressed image as well (to keep it
> > > > bootable on its own). The patch series commit messages contain more
> > > > technical details.
> > > > 
> > > > For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
> > > > used, which are bootable images.
> > > > 
> > > > But that's really confusing that uncompressed vmlinux is still kind
> > > > of booting. May be we should discuss how to avoid this confusion
> > > > (may be change uncompressed image enty point to a function doing
> > > > disabled wait with badb007 or smth) and how to encourage people to use
> > > > arch/s390/boot/compressed/vmlinux instead.
> > > 
> 
> If an image is not expected to be bootable, a message such as "This image does
> not boot. Please use <correct image>" would be nice. Unfortunately, which image
> to boot under qemu is pretty much undocumented, and it is guesswork for each
> architecture/platform.
> 
> Guenter
> 
> > I talked to Vasily and the vmlinux file in the linux source path is just an
> > intermediate file. Future changes will happen that will make that ELF file
> > unsuitable for direct boot anyway (e.g. think about potential ASLR or Kasan
> > changes).
> > 
> >   If yes, it would make sense to explicitly fence it. But I'm
> > > worried that it would break previously working setups (did we document
> > > the purpose of the images anywhere?
> > > 

To avoid confusion with trying to boot uncompressed vmlinux under qemu
we could detect it and print "nice" message in the kernel.

Please consider the following patch.

Vasily Gorbik (1):
  s390/boot: block uncompressed vmlinux booting attempts

 arch/s390/boot/head.S         |  4 ++--
 arch/s390/include/asm/setup.h |  3 ++-
 arch/s390/kernel/early.c      | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
⣿⢿⡿⣿ pacman edition
