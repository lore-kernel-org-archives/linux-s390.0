Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428071;
	b=Su1yBAsCuAEolA0eJ6vCsuoHEXJ8IfkSwwOHHL2ozUJx1EuZLANhYvOa6cU+phj6z2JO
	 u2PtcbheSNu2rkYF8m7mbx2EV8IiSl9/stLqYe8ZY5K2qVXGpefxrvZjEBwSIkc6TSYfC
	 a20TncxkWgSESSv0nBCX251ul4TA4C8bq+newKboczPV5zuDuOi+lnTkFqF76E8xy16bR
	 YFPJnaJL9MxrNNI0uRT0vRsRnMAvWtMJPTFBi9pIycilcSslUartEloNnKtYQYCI8v9gS
	 iDrqhQ2vxfZI+lANfzgwwpE35L/4TsgIQ15X+6ywvVEo8bPC4Q7AI6QzHMOAnxWQL2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428071;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=KF7KKMHocEIKMtcEZJueNr7Dv5+NOCFPSOPv6oq3C0U=;
	b=bNV6wSN3qoDdjXclGs3gtlCeOXQyEwrKeKsU8MQtw5syu0Um4u+uG8Em5oajZaPzxXz1
	 SJEfn7F/Fq39OOql/BQYWCISOSowuvh5Yr3h9SAFPPYPd/MZxtYZ4DFe/59mgkHU4FBVm
	 OsVZyPW4pwJD6w/81MPFZXNnGQo9SACq7k+NHFDOgQZF3bxmmotT5ydmBFPZ3nH9MR3dW
	 ripAxQehgv4AVzFS4Ydd79JTEqjItpxi2EWoDIfg6ldsDw8YfLAlBWE1bewr1Wrd9lZ9J
	 xAuA8+G1sWxT9ffDmUBodeHJONiDPtLKEjAvV/o0IjL4JFqQSSZ0acARCS+eeV2Ygvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0C3DGkSM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=w677fCLK;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6808606A31E;
	Mon, 23 Nov 2026 10:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6808606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0C3DGkSM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=w677fCLK
Date: Mon, 23 Nov 2026 11:01:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795428068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KF7KKMHocEIKMtcEZJueNr7Dv5+NOCFPSOPv6oq3C0U=;
	b=0C3DGkSMNxdoQijZTT1Pd0/49k8ksvpkiee53RaBAssYvJAeUS35fVqreH2YpmDLCnGY7J
	rO7Gn5wzAYN9/F4vvozI6w9BzC77u+HXStilWB//WP/jCLiHL3EwvLERUMRhyTKm31TMC7
	KpFWDUgDZ9oEwKUmRluJIcsleJqxI3m/3IO6SUQ6iBg3DQpuTFLdttDhdIjUgCRF+K4UX8
	1ZqWy0QrOQGINGD9OBCHXgwC/xyk/mMVxzgCYfWKcgAoQQPeB2k6fucPyU5bjbb2tUvTyF
	daEFudcshBIRlr1uzixuvtVp59NZk52rwAQ0az4y31SvRDMxk19gGkRKwezWNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795428068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KF7KKMHocEIKMtcEZJueNr7Dv5+NOCFPSOPv6oq3C0U=;
	b=w677fCLKAWIMDtF3ru07E1bEooFnMvLBIN8Fpo0OkUEt4pY06etT7kQklR7LsARKwrGHA5
	iEX+EeySi8i/r/AA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: s390: Don't use %pK through debug printing
Message-ID: <20261123104414-a16f70e3-223d-4000-a3d0-3983e2e668d1@linutronix.de>
References: <20250217-restricted-pointers-s390-v1-0-0e4ace75d8aa@linutronix.de>
 <20250217-restricted-pointers-s390-v1-2-0e4ace75d8aa@linutronix.de>
 <d2e2ffaa-70ad-460f-bd85-0834a354f232@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e2ffaa-70ad-460f-bd85-0834a354f232@linux.ibm.com>

On Mon, Nov 23, 2026 at 10:41:13AM +0100, Christian Borntraeger wrote:
> Am 17.02.25 um 14:13 schrieb Thomas Weiﬂschuh:
> > Restricted pointers ("%pK") are only meant to be used when directly
> > printing to a file from task context.
> > Otherwise it can unintentionally expose security sensitive,
> > raw pointer values.
> > 
> > Use regular pointer formatting instead.
> > 
> > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Just realized that will debugging something, but this change was wrong.
> The VM_EVENT, KVM_EVENT are not printks, it will rather populate output
> in debugfs files and this output is populated at read time as the debug
> feature stores the format string and the value. So %pK was actually the
> right thing - I think.

Indeed. OTOH %pK is going away completely anyways. So the change should stay.

(...)
