From: Adrian Bunk <bunk@kernel.org>
Subject: s390 kvm_virtio.c build error
Date: Sat, 3 May 2008 20:47:17 +0300
Message-ID: <20080503174716.GM5838@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765619AbYECRsY@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Avi Kivity <avi@qumranet.com>, Rusty Russell <rusty@rustc>
Cc: kvm-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit c45a6816c19dee67b8f725e6646d428901a6dc24
(virtio: explicit advertisement of driver features)
and commit e976a2b997fc4ad70ccc53acfe62811c4aaec851
(s390: KVM guest: virtio device support, and kvm hypercalls)
don't like each other:

<--  snip  -->

...
  CC      drivers/s390/kvm/kvm_virtio.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/s390/kvm/kvm_virtio.c:224: error: unknown field 'feature' specified in initializer
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/s390/kvm/kvm_virtio.c:224: warning: initialization from incompatible pointer type
make[3]: *** [drivers/s390/kvm/kvm_virtio.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
