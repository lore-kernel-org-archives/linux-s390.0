Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934490;
	b=lNUZvzlx2AgCXnkfW2e1hdkNAwJW7PAySWib6eoPcB+Wg2ww5QXORPPTE2TmS2nfPJBn
	 uIanU/lSKD+5vdMEEe1L6pPsCIqm+f1dfJJDgo8VYbasKQv9fVqC1YQZhwpO/9tJGd9/l
	 vC4mw3I20rk7t+EVcBm1msfmp5y/IXedghUQEMeeKERskcuD3S/8tt/VlU+PD/jruutiL
	 ZGisWh2FIq6n27Jv0lgvIrYBeZMy7q2ioUrQ1oVozZQ7T3BPaVfvaOyOKXDfI1aPPyk5m
	 rJwESBrPctyDJN5RS/jqBJBjjLqNzeboWN3T9X10fcIZ16toFFFEuPBURHnrzMFtv1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934490;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Scanned-By;
	bh=CkKLhtnqbVqX+zHwbFhSKHBuVVeu6ZYa3DYw5fokX68=;
	b=qtnEhOfLwTDsxcCMmtWdaOUQKcKNrUwXz7hmewzY9O+tM7j98jazXwYFfgoNqthPf9Vf
	 Q4xV5+jQ3pJLl7VEr/iQCMG20XZml+WrttgD02WgrefTbu/8L2J3weM4wVdglcOE99TBe
	 1/F5DEIbRKoWC6uLnuJdg6IQZfSnAF7PW2Fz3iAw2FrmkvPdNaTuAD72RUsg7r1BOqmKJ
	 MM0PNUjW9kgGfFziE/KoQPRIK+q9ZmFlrMR3zEXbGv3khHzFYOuAd7qWjPgRs0LCjeOpy
	 8ifWQ2RQIbXyRDEm1tUTyMLYM+MbUL1+gW9v/1QRxZ0DHPyPq78SKXisJD1O7RDv4/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JsMsoXM1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5D606A32F
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE5D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JsMsoXM1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794934489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkKLhtnqbVqX+zHwbFhSKHBuVVeu6ZYa3DYw5fokX68=;
	b=JsMsoXM1fWm35TZYmduhQobXmOO3k+8CxVfbbOz9ctG9fi+cO9vFz8aegXNi4fp0q8/V6L
	yphy0Yd+DDNbXkEFNKYIT26Y8Ndr1GlS+JhLQcdagbHg/m1ABxEEfRTdzAhFR54lXK/5vy
	nVqoXctunnMafqHEJeYf8lVc3wKl/Bc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-fB3idbrNOmKXizt0_vf9cg-1; Tue,
 17 Nov 2026 11:54:44 -0500
X-MC-Unique: fB3idbrNOmKXizt0_vf9cg-1
X-Mimecast-MFC-AGG-ID: fB3idbrNOmKXizt0_vf9cg_1794934481
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16238195608F;
	Tue, 17 Nov 2026 16:54:41 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4D02D3001DAD;
	Tue, 17 Nov 2026 16:54:35 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 17:54:40 +0100 (CET)
Date: Tue, 17 Nov 2026 17:54:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Renzo Davoli <renzo@cs.unibo.it>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Davide Berardi <berardi.dav@gmail.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Message-ID: <avyGylgRmpAHan9r@redhat.com>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-2-renzo@cs.unibo.it>
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
In-Reply-To: <20261114181923.370930-2-renzo@cs.unibo.it>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/14, Renzo Davoli wrote:
>
> Add a per-task flag which the tracer sets with
> seccomp_ptrace_skip_syscall() while the tracee is stopped at the
> PTRACE_EVENT_SECCOMP stop, after it has set the return value.  When the
> tracee resumes, seccomp skips the system call like for
> SECCOMP_RET_ERRNO, which every architecture already handles without
> touching the return value.
>
> The flag is cleared by the tracee before the stop and written by the
> tracer only while the tracee is stopped, so it needs no locking: the
> wake-up of the tracee orders it like the registers written by the
> tracer.
>
> The next patch uses this in PTRACE_SET_SYSCALL_INFO.
>
> Suggested-by: Michal Suchánek <msuchanek@suse.de>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

I am not comfortable to review this change ;) Kees, can you take a look?

But it LGTM. So FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



(As for the new new member in struct seccomp... we can probably avoid it
 if you don't like it, but .ptrace_skip looks like the simplest solution
 for the start)

