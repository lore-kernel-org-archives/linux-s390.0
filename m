Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA33E5EF8
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089119; cv=none; b=pU2LSb/sU9Ss/vGIDOQvbsGJxEj7IJ2slcrpypmbXffpVlyOMwPlZYZesXYOfwCRO1BIU4zvIHphpSHPewVtWe9qsS4BWzuhvCy4faEvwu07pcL7eg8GKNAx1+krx+9jj/9lkmtfBX1DcJUfg6h0hBBwW8NczvJf1N5zC1ZBkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089119; c=relaxed/simple;
	bh=BalKS3vcMiL4M+MhyUkm44DgzVA+ep8NFvR33vhB9Nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+SDv+9EvMiP9pnJdohD0QKRS1vw6Y25f9QN0HScjkd+Hu1v6Y6P1jm00/C16x/+WYKLz3UG6lZ+SOgYQ0/Eji/3otQEPdXWCuW+1r4IhINSZ2PbCFExHUNRyOqQe8sVCm7S2y2Js6hWdEj5rwnYkYr62mgWBojhpIoVkBnlZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awZlrBuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awZlrBuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783089116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3K+fcqNdPdHr65XpzEmStmeG7VtATYrfQSoMtvfanDI=;
	b=awZlrBuv7bi1RCyPP4V1WZj9pasAnE9/cQwJOmT4gF1Iv9xoNOTL/Om/z/TkA1q5rKF9Md
	H4C/Pm6Z22BagNnO34Yg4etUp9gtZ4N4ebXGsNLTBO+8XEj7NI9nP+scwYQ3tdNmuuem/c
	EwURFODB2sJLoxiUrKkv83H9EyQmz0E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-0w46kechMT6uz5MLrpdyqQ-1; Fri,
 03 Jul 2026 10:31:53 -0400
X-MC-Unique: 0w46kechMT6uz5MLrpdyqQ-1
X-Mimecast-MFC-AGG-ID: 0w46kechMT6uz5MLrpdyqQ_1783089111
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0EC19792EE;
	Fri,  3 Jul 2026 14:31:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1857A1944B03;
	Fri,  3 Jul 2026 14:31:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a
 new file
In-Reply-To: <20260701164650.95760-4-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Fri, 03 Jul 2026 16:31:47 +0200
Message-ID: <877bnckuuk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
> header file storing function the prototypes.
>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  target/s390x/tcg/cpacf.h         |   5 +
>  target/s390x/tcg/crypto_helper.c | 222 -------------------------------
>  target/s390x/tcg/meson.build     |   1 +
>  3 files changed, 6 insertions(+), 222 deletions(-)

Forgot to commit the new cpacf_sha512.c file?

