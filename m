Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728271AbgDQPCF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 11:02:05 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date: Fri, 17 Apr 2020 17:01:49 +0200
Message-Id: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kirill Smelkov <kirr@nexedi.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

Looking into why we still create memblocks for hotplugged memory (via
add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK on
s390x after all.

After [1] we will no longer create memblocks for hotplugged memory in
case of !CONFIG_ARCH_KEEP_MEMBLOCK. With this series, the same will apply
to standby memory on s390x, added via add_memory().

[1] https://lkml.kernel.org/r/20200416104707.20219-1-david@redhat.com

David Hildenbrand (2):
  s390/zcore: traverse resources instead of memblocks
  s390/mm: don't set ARCH_KEEP_MEMBLOCK

 arch/s390/Kconfig         |  1 -
 drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 14 deletions(-)

--=20
2.25.1
