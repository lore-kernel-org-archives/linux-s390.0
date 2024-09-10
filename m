Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA791AAE23
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995791; cv=none; b=FJHyAVYfv9p28H8EYm6OeMrB/VR3owlOVy4mZ3+t4c14hKvRtuwf1TZGuxJhS7fLDpWjXZO/l9rS5b0diaVXFL1Xo4QxxDnEvh7RnkTDgihyY33dNGN71lbrvppmtJ1O7K1GIumEx0609koKoNXdstCdEJ0UMtB3qFFacdjmkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995791; c=relaxed/simple;
	bh=5AbZneFrwb0hG7IzHsWdJ92AUDYVOma72/NL/xjkm1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDXQQiKIiQw7+Fe656Sxj7mrTVpe+J+DCYucooc1Uh9YeRVBWNP23za2f8x/9ATV5eHMorMnFQb0IwrYgiq/S6gR0jsMdGkbz/YRJ/bKxKWLlLQ6m7pYR9bzjzw0z8jND2FeN5lQ54+moTHNCX9D0faeiqVdWxZTMckeb4DVqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWNM2C8T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWNM2C8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMATIjJHQHWxMji5r7WdDXGhstKkdxXCo0yMMstlfH8=;
	b=ZWNM2C8TqQNfWEiN6cAHxi5RXzN0wAzkFUXVU8r4X1nfww6FCKYaqC3a5klH0YZBmKEMXr
	oFl+uurE40hGGzoy3U37iQTf/MDnNnmdBlP7hCMU1Kw0Ujg+rF61LMjiXlU67k3ot/RExz
	NHmqwX1RWVmZIs/CzMkl4EdD2mO385M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-WbUGol_bMq2IBJu7l5Sszw-1; Tue,
 10 Sep 2024 15:16:26 -0400
X-MC-Unique: WbUGol_bMq2IBJu7l5Sszw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2851955BC1;
	Tue, 10 Sep 2024 19:16:24 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF81B30001A1;
	Tue, 10 Sep 2024 19:16:17 +0000 (UTC)
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
Subject: [PATCH v1 5/5] s390/sparsemem: reduce section size to 128 MiB
Date: Tue, 10 Sep 2024 21:15:39 +0200
Message-ID: <20240910191541.2179655-6-david@redhat.com>
In-Reply-To: <20240910191541.2179655-1-david@redhat.com>
References: <20240910191541.2179655-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ever since commit 421c175c4d609 ("[S390] Add support for memory hot-add.")
we've been using a section size of 256 MiB on s390x and 32 MiB on s390.
Before that, we were using a section size of 32 MiB on both
architectures.

Likely the reason was that we'd expect a storage increment size of
256 MiB under z/VM back then. As we didn't support memory blocks spanning
multiple memory sections, we would have had to handle having multiple
memory blocks for a single storage increment, which complicates things.
Although that issue reappeared with even bigger storage increment sizes
later, nowadays we have memory blocks that can span multiple memory
sections and we avoid any such issue completely.

Now that we have a new mechanism to expose additional memory to a VM --
virtio-mem -- reduce the section size to 128 MiB to allow for more
flexibility and reduce the metadata overhead when dealing with hot(un)plug
granularity smaller than 256 MiB.

128 MiB has been used by x86-64 since the very beginning. arm64 with 4k
base pages switched to 128 MiB as well: it's just big enough on these
architectures to allows for using a huge page (2 MiB) in the vmemmap in
sane setups with sizeof(struct page) == 64 bytes and a huge page mapping
in the direct mapping, while still allowing for small hot(un)plug
granularity.

For s390x, we could even switch to a 64 MiB section size, as our huge page
size is 1 MiB: but the smaller the section size, the more sections we'll
have to manage especially on bigger machines. Making it consistent with
x86-64 and arm64 feels like te right thing for now.

Note that the smallest memory hot(un)plug granularity is also limited by
the memory block size, determined by extracting the memory increment
size from SCLP. Under QEMU/KVM, implementing virtio-mem, we expose 0;
therefore, we'll end up with a memory block size of 128 MiB with a
128 MiB section size.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sparsemem.h b/arch/s390/include/asm/sparsemem.h
index c549893602ea..ff628c50afac 100644
--- a/arch/s390/include/asm/sparsemem.h
+++ b/arch/s390/include/asm/sparsemem.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_SPARSEMEM_H
 #define _ASM_S390_SPARSEMEM_H
 
-#define SECTION_SIZE_BITS	28
+#define SECTION_SIZE_BITS	27
 #define MAX_PHYSMEM_BITS	CONFIG_MAX_PHYSMEM_BITS
 
 #endif /* _ASM_S390_SPARSEMEM_H */
-- 
2.46.0

