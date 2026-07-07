Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7D30100E
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425521; cv=none; b=nwOk/wIGiXRJUTI1msWGXKS7W7WTlaw1vdph4Je618JMb4I1jz3k2p2hgU0KyWp3RNS6twZt78/aHcfod6zLHBiNqIn9sQwXlOlMWgazI7PmYglBuxEXE3KO/WF0+weMTcPpHskJO8wBrqt6dssyiDyNewVqKQdYtZ6gf20V5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425521; c=relaxed/simple;
	bh=avuj63VC3Apox7Uzc2amdABlV7e+A47jxklWwpVHhGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cAcodF+RIJ2M+JhQW97VWvaOZNWeOFXSDasLVeIblEe67fpD2XT+CSqfc5KnayWgJ4CBghFt7rTFeYvUetZQ5599lLoiBKvvtFyRFSrm2qrIWddQXq0n51B/5cAiKCqSBLxb+VlEuV7/iUguk/YzDz5/xe2kD7Bq5sOvP8bSIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPVSISm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPVSISm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783425519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx9ceVBIxTCChNgTGrKuGZRevVRYlusqsxzmiPTO8Us=;
	b=DPVSISm4+eWwvJ9jMMCqVwchGomaFy2a76CVrVgefAjEaL0cAsbsUeijz6mwfVnJTJ3i1q
	EPZa+j1+VqefNtwJlekwmyhjorTMuGHyP67tCv/RvOqKJ8P954QXfZZN9RixNfJ6VvwBf+
	hOrjRmEeWTGmAIP9ennu0dIrxITHoNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-lAZwFgu9MkqGWxIg_eEijQ-1; Tue,
 07 Jul 2026 07:58:35 -0400
X-MC-Unique: lAZwFgu9MkqGWxIg_eEijQ-1
X-Mimecast-MFC-AGG-ID: lAZwFgu9MkqGWxIg_eEijQ_1783425513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501361954212;
	Tue,  7 Jul 2026 11:58:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E353000C01;
	Tue,  7 Jul 2026 11:58:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 13:58:29 +0200
Message-ID: <87bjcjj9ju.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> Harald Freudenberger (21):
>   target/s390x: Fix wrong address handling in address loops

I've picked the first patch as a bugfix.

>   target/s390x: Rework s390 cpacf implementations
>   target/s390x: Move cpacf sha512 code into a new file
>   target/s390x: Support cpacf sha256
>   target/s390x: Support AES ECB for cpacf km instruction
>   target/s390x: Support AES CBC for cpacf kmc instruction
>   target/s390x: Support AES CTR for cpacf kmctr instruction
>   target/s390x: Minimal AES XTS support for cpacf pcc instruction
>   target/s390x: Support AES XTS for cpacf km instruction
>   target/s390x: Base support for cpacf protected keys
>   target/s390x: Support pckmo encrypt AES subfunctions
>   target/s390x: Support protected key AES ECB for cpacf km instruction
>   target/s390x: Support protected key AES CBC for cpacf kmc instruction
>   target/s390x: Support protected key AES CTR for cpacf kmctr
>     instruction
>   target/s390x: Minimal protected key AES XTS support for cpacf pcc
>     instruction
>   target/s390x: Support protected key AES XTS for cpacf km instruction
>   docs/s390: Document CPACF instructions support
>   crypto: Add aes-helpers file to support some AES modes
>   target/s390x: Use generic AES helper functions
>   target/s390x: Improve fetch and store mem from and to guest
>   tests/tcg/s390x: Add tests for CPACF instructions

