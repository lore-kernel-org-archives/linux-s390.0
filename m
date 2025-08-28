Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5330CD8A
	for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352958; cv=none; b=kZNoVu+18DoAQ+4i0WgmoKRVGq6Qn9kNMBqPAeiqzM5jzMcxnGoTOEf0Lw7uDvI7X3vciyIc/GYcyRDSqv/PrTW79pQSWyOTj6DV7WfivWlvbwRTJwNxL/Zxd6ct8WcYVD1tS5oWgVQxK5WRuRZWBX3uTUaY0ibXJdhLChHPUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352958; c=relaxed/simple;
	bh=ONOyllB4SKr1nL03miJXEtQ6HJtKv2bbwr9gyHs3III=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkSs05g7AGTt4z6d3PIpZzYiOmlGFO4X/zMvHrRF/vlAr4yn1zkq1U/0W+QenUA6/EqK+kqbKxBUeE4QByuwaFSZiSG8M/Q37bVMDDDGj3GPonAB8kILCU2uf4rQvm9ODQLvSiQv4nwKWBQ+gxK4kSbKwpMwlxhwIQFaSujcc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D68cqtgJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D68cqtgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756352956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzv1TpitFH2MWtQCE2YAgMRuIwrsgG0F2dWnOgzNbxU=;
	b=D68cqtgJKRsC77X4YPTRjALEKDR+MWeb8QIrGU4JLL51hw16AXtVIgrn79KSaG/RD06VnY
	JytnNrg9m6lDMI+rFtAJV78q7yKFDAGqAKxZmGbArqp6Q/vb97lO1WcXzCr+fWeldLyIpL
	gy2qDZdsLMS7jOpYUG3K/vEULKPm1M4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-oEaYp2oLO5OtXgsJu53zxg-1; Wed,
 27 Aug 2025 23:49:14 -0400
X-MC-Unique: oEaYp2oLO5OtXgsJu53zxg-1
X-Mimecast-MFC-AGG-ID: oEaYp2oLO5OtXgsJu53zxg_1756352952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54EBE180035F;
	Thu, 28 Aug 2025 03:49:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.154])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0E2A1800447;
	Thu, 28 Aug 2025 03:49:09 +0000 (UTC)
Date: Thu, 28 Aug 2025 11:49:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Coiby Xu <coxu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/3] kexec: Fix invalid field access
Message-ID: <aK/RsVZxBw108MNJ@MiWiFi-R3L-srv>
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/27/25 at 03:42am, Breno Leitao wrote:
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
> 
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
> 
> 	------------[ cut here ]------------
> 	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
> 	load of value 252 is not a valid value for type '_Bool'
> 
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
> 
> An initial fix was already landed for arm64[0], and this patchset fixes
> the problem on the remaining arm64 code and on riscv, as raised by Mark.
> 
> Discussions about this problem could be found at[1][2].
> 
> Link: https://lore.kernel.org/all/20250826180742.f2471131255ec1c43683ea07@linux-foundation.org/ [0]
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250826-akpm-v1-1-3c831f0e3799@debian.org/ [2]
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (3):
>       arm64: kexec: Initialize kexec_buf struct in load_other_segments()
>       riscv: kexec: Initialize kexec_buf struct
>       s390: kexec: Initialize kexec_buf struct

Thanks for the fix, all looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

