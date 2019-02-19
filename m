Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/setup: fix early warning messages
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1> <20190218182106.61b10ee4@mschwideX1>
 <20190218191655.103c81ca.cohuck@redhat.com>
 <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
 <20190218233021.368bb475.cohuck@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <eca82ff3-bc07-ee2f-b67a-91425fe1ace0@roeck-us.net>
Date: Tue, 19 Feb 2019 10:47:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190218233021.368bb475.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Cornelia,

On 2/18/19 2:30 PM, Cornelia Huck wrote:

>> What is your qemu command line ?
> 
> Ignoring any additional devices:
> 
> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu max  -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001 -drive file=/home/cohuck/vm-images/vm1.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 -sandbox on -kernel ~/git/linux/arch/s390/boot/bzImage -append "root=/dev/sda3"
> 

Is "accel=tcg" and "-cpu max" expected to make any difference ? CPU consumption
on my system seems to be identical to the default (no -M or -cpu on command line).
This is with qemu 3.1.

Thanks,
Guenter
