Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F43DD50D
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324954; cv=none; b=rp5oTPrI35Pxs6yMUxzNXpnpsPaeD/fL7mab/hw+D6b0QRhHohh0WV5T0C4Rt5PIgEMfZI86i2/qszw3b1/TLXlYDWx+Xf1tu/XXKE9GiryJsKn9c9+YjUnA5rF12mZfDw9ebkbb8vSghWy4PlM83kdoHpx/U4DZnhiK8EbU1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324954; c=relaxed/simple;
	bh=KPf6QSnuTBye0ku4y+66UJmJ/y+HGg1H4Wt97siv1Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ju2+p/fFBUJdYVBhQX0PkgTXHPh2I6Ohh8iFq5ebt40H4dgS/nmdZrXsOjSCI1Ue/QWp6yVlX5jP0qa4jOvOkzIqn/12ucVQHTziLeqlqs2tK1OTNaQWMT0npicAsBifTLNuXFVqTuDYIqiL2oyPG9zxtcSMGp0koIDcB4aDqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEtsYqPa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEtsYqPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783324932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqQoiX8nOstIqMDv9TBNeaeMATrv7hzlmItcdj7mYtY=;
	b=EEtsYqPa9SHlpLJOnQ/RiPDqxdfxTTAaJuaVhaOGxsX/mtXP0taPrX8NO4fk64VnKNxdtD
	fodO2GkS0pExKY2M65yl56dQuvV0RMrUZNsFzhuRZbJOB2dcQoJahqdVpGPALw69QCZhLV
	yIDBTBKsIHkmrfQILkeoRxzSybbIze8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-f90MF37vM6-j2tZnSLWTLg-1; Mon,
 06 Jul 2026 04:02:07 -0400
X-MC-Unique: f90MF37vM6-j2tZnSLWTLg-1
X-Mimecast-MFC-AGG-ID: f90MF37vM6-j2tZnSLWTLg_1783324925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64B2C195607C;
	Mon,  6 Jul 2026 08:02:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6298F18005A2;
	Mon,  6 Jul 2026 08:02:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a
 new file
In-Reply-To: <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com> <877bnckuuk.fsf@redhat.com>
 <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 10:02:02 +0200
Message-ID: <871pdglf5x.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-07-03 16:31, Cornelia Huck wrote:
>> On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
>> 
>>> Move the cpacf sha512 implementation into a new file
>>> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
>>> header file storing function the prototypes.
>>> 
>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>  target/s390x/tcg/cpacf.h         |   5 +
>>>  target/s390x/tcg/crypto_helper.c | 222 
>>> -------------------------------
>>>  target/s390x/tcg/meson.build     |   1 +
>>>  3 files changed, 6 insertions(+), 222 deletions(-)
>> 
>> Forgot to commit the new cpacf_sha512.c file?
>
> Yes - the last rework ...
> Shall I send out v10 with only this missing file fixed ?

Just send out the complete series, that makes it easier to merge.

