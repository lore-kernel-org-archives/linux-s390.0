Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E033A00C;
	Fri,  4 Sep 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562248; cv=none; b=Dk9u8vLmqblorkRuUVocnYwd971kvs+5BHoZCbIfRnW1FS64r/mF0sX3ze85CrL30jvFqiVHBUS3x/VnGHRkmHgIcgAtC6XGXLLDuAN4REcvFtMDO9BYmv2AT8Pr3fVMOnM+BQwV2c0PWnFwFe8u7YdMYaqF0v5c7ixDHv0wYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562248; c=relaxed/simple;
	bh=9JPBTfH/t1JvVH4BMzUDxkvbPYiN340i86gkjqwJM0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HWxdO0Nk0hRzu/eBjgrhY8/8sUJLnVUpV+5JOA2JS3oK7aaIa48KQV13PHT0iZTI6/rFf1jsDfKi6gzx+qA9HbQvQ+xIF/0ssktIEzsnMLTC6G4s5ToFdxrdLGoon9g4FUdGKB3BlxOjl2+gERN2mgeaqW9eH6EJDvGztyq/G+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUqKUE8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUqKUE8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F02F1F00A3D;
	Fri,  4 Sep 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562247;
	bh=9JPBTfH/t1JvVH4BMzUDxkvbPYiN340i86gkjqwJM0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUqKUE8Y/GBIBxxqBEIAz4xvnzSvz5QbX0X0Scl0MMcwTKYUFRUs9+sFBq5G1oDSY
	 k1o4FqgmnkRRtpvlGCjN285W3E9ZanpefEcdtuzyF4MfouA1jqIb3If7hgimHBnECf
	 DetckucVw7r5jJawcu43nI9OV+J0b8K1W25jGciP2ZkHPdFRNCtE6gtumlzSZgh+zG
	 MIS59TqJLzTN33PbZKxdLx9frdgqAjDTXiJyIK2bqp7ct7Pts9REeVl9qC+4kpsKRx
	 JEC3eCOCWHjM0TBgkrLDVkRWgVYC2e3cQU++0e9XLONEO1BmHP2Iuaxg4kbtt+notJ
	 PxT6jnWGtX1lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] s390/vfio-ap: replace guest-reachable WARNs with
 ratelimited               warnings and add dmesg visibility to DBF_WARNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904223531.1611088-7-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:50:46 +0000
Message-Id: <20260904225046.9F02F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> WARN and WARN_ONCE macros in code paths reachable by a guest
> can be triggered repeatedly by a malicious or misbehaving guest,
> flooding the kernel log and potentially impacting system
> stability. Replace all WARN and WARN_ONCE calls reachable from
> the guest AP interrupt enable/disable and queue reset paths with
> ratelimited warning functions. When the queue is assigned to
> an mdev, dev_warn_ratelimited() is used so the mdev device name
> (which includes the UUID) appears in the message. Otherwise,
> pr_warn_ratelimited() is used.
>=20
> Four reporting functions are introduced:
>=20
> report_tapq_rc() - reports an invalid or unexpected response
> code from PQAP(TAPQ). Used in vfio_ap_wait_for_irqclear() and
> apq_status_check(). The signatures of both functions are changed
> [ ... ]
> dmesg log entries ensure that warning conditions are immediately
> visible in the kernel log without requiring familiarity with
> the s390 debug feature infrastructure.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D6

