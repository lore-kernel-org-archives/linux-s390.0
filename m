Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410F17BEBD
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995758; cv=none; b=NeJ1P1HK2olja5VCY9wu2geTBSwqboktu9XzUNZJsPo4tAN2ACtbh9nSD72a44WEsmDc6iQPUTwLCqIpB38zX15wmfno4Ofdti074xq99Q74qFH0Xpahd9HeWASp8g8VzmcGX97EWpJQfd6lzlVt3AkBkTxLyEUca61fviRS244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995758; c=relaxed/simple;
	bh=a3o8r3j7e6l3ccPyz2pgENLkugurZOSijOv6eHzX2ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PONS4jO7mwOL8Gbz8bkAqtolgXMwDdMQhXX/cOhkXcFA2+U/gicJ/6mH3UuaYh0R9PAcVEb8Qau/LIajqj1spWz3xO/5CjDxgjm0N1SkpqKAsrbv/gUMePIoa5xwH2E7Fn4q0DgGasWx7eFXjMKyb8/li4ycwXCQS4lOaAUcVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4nij0+1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4nij0+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p5VO7xFGUC34u9yUYNmEroA6AIpumzSXtSSwu0Hwc8c=;
	b=Y4nij0+1RWML7HE59VjJGdj2P70MhwVyi3TmChy0BRAD92kPszLpb2cUMZCDFi32MdE/k4
	hxTEviUhzKdOdQgSOaJl2oZH1/ph52BMwQrHG9Vl+q8gfLQ2YCn3HBEY7R8ZN0HT7wm/0/
	Mrr9y+0wILQMcJeYaDv4kCkBGKZkoiM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-1Yk_m0wcPrS7gXs10S8K3w-1; Tue,
 10 Sep 2024 15:15:52 -0400
X-MC-Unique: 1Yk_m0wcPrS7gXs10S8K3w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7521E1953945;
	Tue, 10 Sep 2024 19:15:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 891B93001D0F;
	Tue, 10 Sep 2024 19:15:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/5] virtio-mem: s390x support
Date: Tue, 10 Sep 2024 21:15:34 +0200
Message-ID: <20240910191541.2179655-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's finally add s390x support for virtio-mem; my last RFC was sent
4 years ago, and a lot changed in the meantime.

This is based on mm/stable.

I sent out the QEMU part earlier today [1], that contains some more details
and a usage example on s390x (last patch).

There is not too much in here: The biggest part is querying a new diag(500)
STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end". Once this
and the QEMU part will go upstream, it will get documented in [2]

The last two patches are not strictly required but certainly nice-to-have.

Note that -- in contrast to standby memory -- virtio-mem memory must be
configured to be automatically onlined as soon as hotplugged. The easiest
approach is using the "memhp_default_state=" kernel parameter or by using
proper udev rules. More details can be found at [3].

I have reviving+upstreaming a systemd service to handle configuring
that on my todo list, but for some reason I keep getting distracted ...

I tested various things, including:
 * Various memory hotplug/hotunplug combinations
 * Device hotplug/hotunplug
 * /proc/iomem output
 * reboot
 * kexec
 * kdump: make sure we don't hotplug memory

One remaining work item is kdump support for virtio-mem memory. I
am working on a prototype that will be fairly straight forward,
because the virtio-mem driver already supports a special kdump mode and
dracut will already include it in the initrd as default. With
holiday and conferences coming up I rather sent this out now.

[1] https://lkml.kernel.org/r/20240910175809.2135596-1-david@redhat.com
[2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
[3] https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html

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
Cc: Andrew Morton <akpm@linux-foundation.org>

David Hildenbrand (5):
  s390/kdump: implement is_kdump_kernel()
  s390/physmem_info: query diag500(STORAGE_LIMIT) to support QEMU/KVM
    memory devices
  virtio-mem: s390x support
  lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390x
  s390/sparsemem: reduce section size to 128 MiB

 arch/s390/boot/physmem_info.c        | 46 ++++++++++++++++++++++++++--
 arch/s390/include/asm/kexec.h        |  4 +++
 arch/s390/include/asm/physmem_info.h |  3 ++
 arch/s390/include/asm/sparsemem.h    |  2 +-
 arch/s390/kernel/crash_dump.c        |  6 ++++
 drivers/virtio/Kconfig               | 12 ++++----
 lib/Kconfig.debug                    |  2 +-
 7 files changed, 64 insertions(+), 11 deletions(-)

-- 
2.46.0

