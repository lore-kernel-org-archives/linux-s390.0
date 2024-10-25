Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF937BB15
	for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865712; cv=none; b=VOv/oIUvcM9wgavYmi5I/bkPE/s9KDaP8cErD/009fEbPHDpqVsAEW0P4UMAu9M0iYHDWQshaI8FBxhYZ5KsCeF6jYDRikGVWks1ZFSmb22lId28L8ZnWPyCpz+iAb2VxaWbbIGkw11Kdmzhvim4FnBk2IUvF9oTfAueB84KjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865712; c=relaxed/simple;
	bh=eVjDySFNHYvLkJiFndXO4WwDtQ50lC6XGvV99R9ck9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s18AO0sjXuGylzrngozPs9XgirpYqSTf0SkNdWFQDS6GzMdpWhI3olN+FKJcDNUPLMG6Owar0BcbcPsO7xeKB24khsJe0t6qFmVFztQmLuysnLWKOWwGLwaznw0cZZ67f79KWf3+o/BMc+ilPZ2pLCIQ7T3Hkt4Ss6l18EozfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKt78Sor; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKt78Sor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729865709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ff6XQKworBBc6g+g+GISIC2w5/BR0dZAOdIhNYuIBxY=;
	b=JKt78SorW3qqUZQeBVC5DJX0WJ30/nGl41b5qyF6giECejaEzmRfZc8b1KjllQ/N4mlqpw
	R5fGNAMUUtXV5d9s4SMJ1iN7wVphJKg/EPSGYetQJ7Cwv1LyW8OedR/UWsFnlf6ZUWwHWd
	CUfzN6sx2H6lGL/uJM1pRsP0ABbLcDs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-hdlqc4_INZygg1ik9ibmHw-1; Fri,
 25 Oct 2024 10:15:05 -0400
X-MC-Unique: hdlqc4_INZygg1ik9ibmHw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D061719560A6;
	Fri, 25 Oct 2024 14:15:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B94FE1955F30;
	Fri, 25 Oct 2024 14:14:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/7] virtio-mem: s390 support
Date: Fri, 25 Oct 2024 16:14:45 +0200
Message-ID: <20241025141453.1210600-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's finally add s390 support for virtio-mem; my last RFC was sent
4 years ago, and a lot changed in the meantime.

The latest QEMU series is available at [1], which contains some more
details and a usage example on s390 (last patch).

There is not too much in here: The biggest part is querying a new diag(500)
STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end".

The last three patches are not strictly required but certainly nice-to-have.

Note that -- in contrast to standby memory -- virtio-mem memory must be
configured to be automatically onlined as soon as hotplugged. The easiest
approach is using the "memhp_default_state=" kernel parameter or by using
proper udev rules. More details can be found at [2].

I have reviving+upstreaming a systemd service to handle configuring
that on my todo list, but for some reason I keep getting distracted ...

I tested various things, including:
 * Various memory hotplug/hotunplug combinations
 * Device hotplug/hotunplug
 * /proc/iomem output
 * reboot
 * kexec
 * kdump: make sure we properly enter the "kdump mode" in the virtio-mem
   driver

kdump support for virtio-mem memory on s390 will be sent out separately.

v2 -> v3
* "s390/kdump: make is_kdump_kernel() consistently return "true" in kdump
   environments only"
 -> Sent out separately [3]
* "s390/physmem_info: query diag500(STORAGE LIMIT) to support QEMU/KVM memory
   devices"
 -> No query function for diag500 for now.
 -> Update comment above setup_ident_map_size().
 -> Optimize/rewrite diag500_storage_limit() [Heiko]
 -> Change handling in detect_physmem_online_ranges [Alexander]
 -> Improve documentation.
* "s390/sparsemem: provide memory_add_physaddr_to_nid() with CONFIG_NUMA"
 -> Added after testing on systems with CONFIG_NUMA=y

v1 -> v2:
* Document the new diag500 subfunction
* Use "s390" instead of "s390x" consistently

[1] https://lkml.kernel.org/r/20241008105455.2302628-1-david@redhat.com
[2] https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html
[3] https://lkml.kernel.org/r/20241023090651.1115507-1-david@redhat.com

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>

David Hildenbrand (7):
  Documentation: s390-diag.rst: make diag500 a generic KVM hypercall
  Documentation: s390-diag.rst: document diag500(STORAGE LIMIT)
    subfunction
  s390/physmem_info: query diag500(STORAGE LIMIT) to support QEMU/KVM
    memory devices
  virtio-mem: s390 support
  lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390
  s390/sparsemem: reduce section size to 128 MiB
  s390/sparsemem: provide memory_add_physaddr_to_nid() with CONFIG_NUMA

 Documentation/virt/kvm/s390/s390-diag.rst | 35 +++++++++++++----
 arch/s390/boot/physmem_info.c             | 47 ++++++++++++++++++++++-
 arch/s390/boot/startup.c                  |  7 +++-
 arch/s390/include/asm/physmem_info.h      |  3 ++
 arch/s390/include/asm/sparsemem.h         | 10 ++++-
 drivers/virtio/Kconfig                    | 12 +++---
 lib/Kconfig.debug                         |  2 +-
 7 files changed, 98 insertions(+), 18 deletions(-)


base-commit: ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc
-- 
2.46.1

