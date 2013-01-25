From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH v6 00/11] s390: channel I/O support in qemu.
Date: Fri, 25 Jan 2013 14:15:09 -0000
Message-ID: <201301251415.r0PEF93K029868@d01av03.pok.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, None <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Hi,

Thank you for submitting your patch series.  checkpatch.pl has
detected that one or more of the patches in this series violate
the QEMU coding style.

If you believe this message was sent in error, please ignore it
or respond here with an explanation.

Otherwise, please correct the coding style issues and resubmit a
new version of the patch.

For more information about QEMU coding style, see:

http://git.qemu.org/?p=qemu.git;a=blob_plain;f=CODING_STYLE;hb=HEAD

Here is the output from checkpatch.pl:

Subject: s390: Add s390-ccw-virtio machine.
Subject: s390: Add default support for SCLP console
ERROR: do not initialise statics to 0 or NULL
#72: FILE: vl.c:2468:
+    static int index = 0;

WARNING: braces {} are necessary for all arms of this statement
#126: FILE: vl.c:3923:
+            if (default_sclp)
[...]

WARNING: braces {} are necessary for all arms of this statement
#135: FILE: vl.c:3937:
+        if (default_sclp)
[...]

WARNING: braces {} are necessary for all arms of this statement
#144: FILE: vl.c:4109:
+    if (foreach_device_config(DEV_SCLP, sclp_parse) < 0)
[...]

total: 1 errors, 3 warnings, 114 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Subject: s390-virtio: Factor out some initialization code.
Subject: s390: Add new channel I/O based virtio transport.
Subject: s390: Wire up channel I/O in kvm.
Subject: s390: Virtual channel subsystem support.
ERROR: need consistent spacing around '*' (ctx:WxV)
#56: FILE: hw/s390x/css.c:31:
+    SubchDev *sch[MAX_SCHID + 1];
              ^

ERROR: need consistent spacing around '*' (ctx:WxV)
#62: FILE: hw/s390x/css.c:37:
+    SubchSet *sch_set[MAX_SSID + 1];
              ^

ERROR: need consistent spacing around '*' (ctx:WxV)
#74: FILE: hw/s390x/css.c:49:
+    CssImage *css[MAX_CSSID + 1];
              ^

total: 3 errors, 0 warnings, 1469 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Subject: s390: Add channel I/O instructions.
Subject: s390: I/O interrupt and machine check injection.
Subject: s390: Channel I/O basic definitions.
Subject: s390: Add mapping helper functions.
Subject: s390: Lowcore mapping helper.


Regards,

Anthony Liguori
