Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB329413D69
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825720; cv=none; b=IHU9nYQQbXinUizy3UyMepTN6sy02+T+fHHMMieFZ9AkCStJX5cRvdumxcRzbVyyqSyvlu2DP0S9Hercz69Iu54rOZ6oBZuLFe47GiTFdvc7lLK3MD2BoIBzYuK3v9/pUiGfOTmipk9kYhYl1g0ruy6/yHgGJ8lB/g01EHRs3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825720; c=relaxed/simple;
	bh=fvvCtgRg2vwFmeJK+BSLf33yAtiofR7jA0bQsJGULQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M33ayV/yHTsx/uJpFAOnFYFmQShgbDMBwe/lhJ/2y2nNCh3MWl7v4q/LpPlJb0N23gurZb/k5B5lFl9uuNW/G6mblokLz8NnArx3gH8g5hAq3cUJwJXSOdaeGJ6mL4bhebsYHwWJK+ArryOmfgzcX/1ikzhRIxEE0TZYaRcd3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZUwlxYf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZUwlxYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782825718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id6Gn72flvltTtLNae1NVFOonek88cQ4TW8gPOjfsjY=;
	b=iZUwlxYfbeRuT49MnhqB7ICQ07D/aL9DSnCQZMSbvwN2GVXUoODrftQzDKSaETedoQDyrk
	7Vo2+8Swaf0pS/Pv+sLlgLaes4ag3ez08ZJwGtor1zjiKqZjv1CScKvVaRjX241GdSwvJP
	kqRLoRTMRuhlSusqEeJayA3AOfRhcUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-USCyT9AgNUyJnVoqc8Mr2Q-1; Tue,
 30 Jun 2026 09:21:54 -0400
X-MC-Unique: USCyT9AgNUyJnVoqc8Mr2Q-1
X-Mimecast-MFC-AGG-ID: USCyT9AgNUyJnVoqc8Mr2Q_1782825713
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D57E71955D5A;
	Tue, 30 Jun 2026 13:21:52 +0000 (UTC)
Received: from localhost (unknown [10.44.34.134])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23217364F7;
	Tue, 30 Jun 2026 13:21:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico
 =?utf-8?Q?B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390x: stsi: regression test for the STSI 3.2.2 count
 clamp
In-Reply-To: <20260629091921.710920-1-borntraeger@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260629091921.710920-1-borntraeger@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 30 Jun 2026 15:21:49 +0200
Message-ID: <87ik70kvte.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Jun 29 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> See https://lore.kernel.org/qemu-devel/20260622092035.400959-1-borntraeger@linux.ibm.com/
> for the QEMU fix.

Could now also refer to QEMU commit a57e4612b61d ("s390x/kvm: clamp stsi
3.2.2 size") directly.

> Add a regression test that races STSI 3.2.2 on one CPU against a second CPU
> that continuously forces an out-of-range count value.
> The out of bound access usually crashes/asserts QEMU with any sane
> distribution build of QEMU, so its more or less guest root can kill itself.
> We should test and fix nevertheless.
> Testcase piggybacks on the existing stsi test, so some cases will be
> tested twice. (with smp 1 and smp 2)
>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> ---
> If wanted we could split this into a separate file or always run the
> test with smp=2 to avoid the duplication

I think it's reasonable to keep this with the other STSI tests.

>
>  s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
>  s390x/unittests.cfg |  9 ++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>

FWIW,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

