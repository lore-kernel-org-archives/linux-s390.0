Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E1432BE6;
	Fri, 31 Jul 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503692; cv=none; b=BOvnoonU82AL5QAVUyXf0vgx8oBhJNQOiimETtRy+Gj/3s9oyUtZY90lbM/U2KICHYN6dwkWTCsv9xOOeakxEAGB/NxDqMxoyXRVsvRxFGRdn8V2U2uA7irDP9Nmi50YWSbfcYHMgN87QinPp+gp5KAqPbqcb8nfe1m1G3QdkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503692; c=relaxed/simple;
	bh=g4ytOK8dGjLzg2FZ3hMbVG4Px2VALisCIEq6ofWse3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTBLBV3esXUz529878+zKEObGL6XwhcF6/5YOWNNp6/G5I7yE3F+6TX6k5jyJMJcTh6uW9yCXQ4ktcRDqkkTzUcQiPqAYaK8e5C8Ksdk4ptE+KuTfhtVW2FOySAsdwbYY50GgBdRxIHopuW9zNLaaYv6TwDfQDWqWbodhJTxlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVsqqVsH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVsqqVsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7119D1F00A3A;
	Fri, 31 Jul 2026 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503691;
	bh=g4ytOK8dGjLzg2FZ3hMbVG4Px2VALisCIEq6ofWse3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVsqqVsHsbb82i3oPSEspUUwUqzafa5NMoBfxqosJa48jPfDLvnOpv8yCGVlovKV7
	 uVvYITz3juVnVE7v/NSqRD5Q9SPgiejD6CuSbnwJ4igE1Y0Vqm7wnFfsuiOzJvBKWS
	 9dgaq3Fq9Wb+A6Fe//D5FNGXd84d/QpIZW7yCuC7marx2qorZR+Ulme+v2lIC9Kmvc
	 FVrjf5EYWhOjNOqMphS2319yGUMSMXDCopD8DqQLd/7CO6A0fPnaEPaH9nRkmf1jrq
	 TVPKMqMxiXmu3KvIUm+qIx/XAuHx61DZMEFEJiLHQexiVqmazfvx/vpVvZ/9VlZvdk
	 Gt86BctqxEqpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130138.173983-8-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:14:49 +0000
Message-Id: <20260731131450.7119D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D7

