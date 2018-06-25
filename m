Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: s390 qemu boot failure in -next
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
 <20180625100548.64222dad.cohuck@redhat.com>
 <your-ad-here.call-01529915788-ext-6027@work.hours>
 <20180625104928.6c4cb239.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Jun 2018 14:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180625104928.6c4cb239.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <76740f8f-ef4c-9d11-dae1-192beebff4d8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/25/2018 10:49 AM, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 10:36:33 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
>> This change has been done on purpose. Uncompressed image is not going
>> to be bootable any more. In future the decompressor phase would get
>> more function (early memory detection as an example) and there is no
>> chance to duplicate that code in uncompressed image as well (to keep it
>> bootable on its own). The patch series commit messages contain more
>> technical details.
>>
>> For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
>> used, which are bootable images.
>>
>> But that's really confusing that uncompressed vmlinux is still kind
>> of booting. May be we should discuss how to avoid this confusion
>> (may be change uncompressed image enty point to a function doing
>> disabled wait with badb007 or smth) and how to encourage people to use
>> arch/s390/boot/compressed/vmlinux instead.
> 
> So, the intention is that you can't boot the uncompressed image
> anywhere? (Was it possible before, e.g. when punching the image under
> z/VM?)

The uncompressed image (the vmlinux file) was never bootable in LPAR or z/VM.
It was just a "nice hack" that QEMU was able to do so. (even qemu on x86 can not
boot the pure vmlinux file as far as I know).

I talked to Vasily and the vmlinux file in the linux source path is just an 
intermediate file. Future changes will happen that will make that ELF file
unsuitable for direct boot anyway (e.g. think about potential ASLR or Kasan
changes).

 If yes, it would make sense to explicitly fence it. But I'm
> worried that it would break previously working setups (did we document
> the purpose of the images anywhere?)
> 


I think by referring to arch/s390/boot/compressed/vmlinux things are probably
good enough. That will still load from 0x10000.

We might still "change" the way that we add the parameters (e.g.
make that not depend on the load address), but looking forward this might
become less important for the "intermediate vmlnux file".
