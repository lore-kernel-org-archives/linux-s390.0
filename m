Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C723002BC
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717339; cv=none; b=C40IiowpNh2pFcCWkGHmIcXVJBKqaZKx5uO5+La57AvJaaaNSo0Qfy1DznJTbSDzYQtYsQGm6PMCk786s16iW9KlOKTUR5D7hyrsXep0uKCTcKlFsXS8/tiIO90qNO2xB1ACgDdeM9A+jDanaQr3Cys4GyVFBGpqo/dKOx12kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717339; c=relaxed/simple;
	bh=ziSK8lEr1aNzouKQKGg3Z2wKaoSBvRJnFd1y2upGG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSsKl+ZPGDt8t4bt2tM5tWT9qYihxa+TWV1UMxlE56xJdSowzGVFVVwZLjqsamCA5mLpSmxu6hR8/A74tGPel2e7yhU9bAQjzPCenwUb+1MCwCl6P6GIzL1gObiItah7SEr0hne571Yc+sfpwCLbBGVYU9u5TQ08FziAcm54lWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cr+2NSCa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr+2NSCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756717335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPvlEW8PtLKIanxybkO1/0NkrQlUhYQIU4DMz23K2u4=;
	b=cr+2NSCavS4nbuQQOEaJoE3MvlZXO51osKLPQAlHIfqb/Cn+jULDWdGSOlg+7h01XqaH38
	TDeUgE8fLv93fi51sb9kZ6kDQZBW6tYR+0E1Cnjbij/zmTYxbTYaKV4Hdp9/Pd30F7Sojm
	naIGhfhSkV9ieISXCEO9fnp8Hm2GrKE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-8mFGJcPuO_W8J2hAjUmw-w-1; Mon,
 01 Sep 2025 05:02:12 -0400
X-MC-Unique: 8mFGJcPuO_W8J2hAjUmw-w-1
X-Mimecast-MFC-AGG-ID: 8mFGJcPuO_W8J2hAjUmw-w_1756717329
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC7F5180035D;
	Mon,  1 Sep 2025 09:02:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D57730001A2;
	Mon,  1 Sep 2025 09:02:06 +0000 (UTC)
Date: Mon, 1 Sep 2025 17:02:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Coiby Xu <coxu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/3] kexec: Fix invalid field access
Message-ID: <aLVhCuzhRTRnDytw@MiWiFi-R3L-srv>
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
 <f7d55c91-8877-41aa-8cf0-64af38a9a109@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d55c91-8877-41aa-8cf0-64af38a9a109@ghiti.fr>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/01/25 at 08:42am, Alexandre Ghiti wrote:
> Hi Breno,
> 
> On 8/27/25 12:42, Breno Leitao wrote:
.....snip... 
> 
> I see that the commit those patches fix is in 6.16 so we should add cc:
> stable.
> 
> And who should merge those patches? Should we do it on a per-arch basis?

It's been in Andrew's akpm-mm/mm-hotfixes-unstable.

