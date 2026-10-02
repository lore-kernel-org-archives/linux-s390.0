Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00A39FCC4
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970551; cv=none; b=r/Rul/ju2ptf5EKxYsVzvF86+jxT84p3JlhD777PpdDA4nDXmkYbtUCyF2EGkBiW4K6Q90zGAgJmy/43UlgNna/AYnXRsf/oZje1c8bGdq8Yitv5e4kGv1JQdnBFHHC/vCKTuLG7lkXLOokjpSy3PbmmP6UOHs9E50L8oLqU51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970551; c=relaxed/simple;
	bh=BA1c0FkHJccaJp4mZY2Xa5/jpWSQsLFKfIsyjBoOSVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8Qn+8UUwVYyGJNf2uYRDJ0ZZYTROOijLsMuwucwbuSsW8YTU2//XVKLuItLyR5oUkKToe3iSYTTVDTHmH01QKNlB4HEx7JGGf6IoetCr9m8iQ6ZDyyjtCQtWfBG+QTfO+iA1KlEGf0nlF2WAZLEGUk1ED9zsguJ+3pG2UtJU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QsejfObb; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QsejfObb"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1438cb9b3a3so7100622c88.2
        for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970548; x=1791575348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Jk2g6BtdlmGdKtgGPAbggZvehqRrTlA+cJG1wv2zZM=;
        b=QsejfObb/wmxhikAczTsark7ZpSrYCvIQl5XPSnMm/hGeLmkfX4dgBuSqy5CgGEo2b
         fSZYLKo3Y0o9HWu2edVzj5GnPMsWOxTqDccXNCwmT/tZHdDu/Jr8eWsXFPojIkLYJVfE
         iH1++2yXRyQjDl11Edeto+CvX2m+DJMtlYNxSIcgKjpRZUlOSd61XyvkXuObjjoOQbjK
         OSofm00Jkxapfea2E+mJ08H8mF7QSWZ3rh1wqW3N9w0JfxS88eLQAB3dpYsX4ZmaW71y
         wFPWNX1hzTIXoJVQPFvzY+IcsE1Mq8OQ4LMzvxhvguDf59ezkJxL89PtZyEgSifzPxJa
         H/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970548; x=1791575348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Jk2g6BtdlmGdKtgGPAbggZvehqRrTlA+cJG1wv2zZM=;
        b=Li/4dghdqZ7A1SWX0VxXxRTXkx6wp4wPXfTP0viK3rZYtwwuEOZ5a09oJYXx/0VHd8
         zX9dOTkVkiqsevkNUdyPr9A3OvCckB0O/l34SHML9LuCALlljRncs1ys4VZdyjrG0St2
         gulcaLNuDQnTz3k0lQDew+LnO2NhVih9ICAkhi8rt4GRtKBfUlPMIt1h7kd5HP2JdoNF
         wUl0pxZxTOTIuLZO9/WhyQskPM8bnNaImvUVgZW5iOfDSZ0MnPSKkhEQaYcv8uxWUMda
         sB62aekk2z1I03hI0VRUXKNK+5l261yaxL1bmLBH2abOYvGRBp7P2ornwYVTvZlK/7XO
         eC4A==
X-Forwarded-Encrypted: i=1; AKwUvBx7P5r8TCGowvOlxY3G3trEUeE/1mvLipazq5GfNLBkiGgFd9BZLUyjy7906c3hTn148o5VQIdnxtFN@vger.kernel.org
X-Gm-Message-State: AFuF++kiSLc8ato+c4ajOYwbdQN54xIZuNgZLK4TSiiUKMv6d55i9xWI
	2DRqTT6B3liKEZRvTdT4mLW2ZbGeqj6DGTGVJg6K8Bk8PqBWzThl2m1EeV1CwkO6ysw=
X-Gm-Gg: AYBFou2ketXo/J0Hm9k8/ffRi0Zru2f3xJNarRQyg0G7RpVaoO5ALWCS0Yjl5G7FHTy
	gyWFIuNZao/yyBCKj39IbFlKF02fPtM9sFR9DBkCz8wJopl1/DVa5SVGSUQH0mapa7b3cXPIhbg
	RZsv0pApROEC8YXIi5qHcnDxDpYu3Y/IgPokuwcg/zoNUbwT/ABwAtVq4ha4lkSVEM+BpKke8GQ
	MskmUKmNFRYjrpGBZi37CgAnzXgtWa+qtFIZUdvELy1UCNtDi5OvVINe2BhftqGY22y6o10ArnE
	rXScG+DfInHvDNe8DdbA3GEmuBBz081Bbnv4jhFumxIpOGH/aZEqLuzAGPb5Gmj1xPZYN3S+kGj
	rYfP3OcsnmsDpvvHOGEOE/2SnezGocbQhj0gvqPBAytBcVoa+XIe9gunPDZvdopLMrozJpVI9OP
	dybG6+dn3ad93mED36dN3yDPkcxdiJv0VbLlAs8aJfkLdrS6O3kPu5qiiqYFDqq4zjOT0WPGmJM
	wkXoW6h5I77Ris+D2aSo5Cnl3M7U6foBv23kowMFOSvmxvZFrvkTRD+XWSVY+VysDKku140nPTK
	TIdzMg==
X-Received: by 2002:a05:701b:42c9:10b0:14f:b80a:33a5 with SMTP id a92af1059eb24-14fb8197636mr2873373c88.28.1790970548456;
        Fri, 02 Oct 2026 12:49:08 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14fae9b3dfesm6697431c88.11.2026.10.02.12.49.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:49:07 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	avi@redhat.com,
	cotte@de.ibm.com,
	david@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 6.1.y] kvm: s390: Reject memory region operations for ucontrol VMs
Date: Fri,  2 Oct 2026 15:49:03 -0400
Message-ID: <20261002194904.21236-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

[ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]

This change rejects the KVM_SET_USER_MEMORY_REGION and
KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
This is necessary since ucontrol VMs have kvm->arch.gmap set to 0 and
would thus result in a null pointer dereference further in.
Memory management needs to be performed in userspace and using the
ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.

Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
and KVM_SET_USER_MEMORY_REGION2.

[ Backport to 6.1.y: omitted KVM_SET_USER_MEMORY_REGION2 documentation
  because that ioctl is absent from 6.1. ]

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Fixes: 27e0393f15fc ("KVM: s390: ucontrol: per vcpu address spaces")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20240624095902.29375-1-schlameuss@linux.ibm.com
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[frankja@linux.ibm.com: commit message spelling fix, subject prefix fix]
Message-ID: <20240624095902.29375-1-schlameuss@linux.ibm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and kvm s390 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-43819. It rejects memory-region ioctls before a
ucontrol VM can dereference its NULL gmap.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-43819
Upstream: 7816e58967d0e6cadce05c8540b47ed027dc2499

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 Documentation/virt/kvm/api.rst | 6 ++++++
 arch/s390/kvm/kvm-s390.c       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1bc61bf804f1f8..1f0f84501e59c8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1382,6 +1382,12 @@ The KVM_SET_MEMORY_REGION does not allow fine grained control over memory
 allocation and is deprecated.
 
 
+S390:
+^^^^^
+
+Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
+Returns -EINVAL if called on a protected VM.
+
 4.36 KVM_SET_TSS_ADDR
 ---------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c7b4c0d37c87b0..0caaa462baf6f8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5587,6 +5587,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 {
 	gpa_t size;
 
+	if (kvm_is_ucontrol(kvm))
+		return -EINVAL;
+
 	/* When we are protected, we should not change the memory slots */
 	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
-- 
2.39.5

