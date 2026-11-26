Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701889;
	b=T9jGMw+ALv0NRgcDZY3bZIGC+HbqVs/6QP+iYPeNcyuIU4WGScEZ797/AjNrMSmPDzIz
	 DoTOio33Su5uR8BTgFhgJrWCnE04u5u1Jmhbt2h/A4ZNQJxoATHlRk+UpPLUpLDiaw3HU
	 atCOSP9nnTs+kaIaRe2fS1TX8RGlQR52o/y6gkJQYUbjncYae6hmI1JmhXAtDPPga7NkL
	 /A2p+cG4a6c2BPkG78/S0/MEx23K4trcGsrlSoNEDItBM1K/Ox8XAQPQBN8EgARwUez0L
	 ESMV0qFm8aW86nthxHFdNTlk18OFD7euKWDT+SzZtuAjoN+mY4rj6fkUt1RIjwJzOUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
	b=5aEy5ntnNvTQRqtFl2uQwh1MIaeVvxImnqT0DBEzKN9rjv1SA7mwggF7dKh5HXSomqi5
	 zcDwMDA8vDnPMPR8VCoa4ETNWKZDE/jh7d4AqkQw6Rg6Dw/iLKfenC8GCgNMmzt6dJlQa
	 ZkzLgj9BApJNoXDJyDFdG2SRlERa3mybQLxIHOz3bbYanXYcYlAXHkTTztMTljLuvD/Dj
	 B0cRHAqwRltkGOvTquqNGutXP2gZmqqdQJT0fBFpQ4CuyFAfQtwFtquGNV78qsdW3bssg
	 HZ6N9ejFort7VPnTbFYwTlNoGdSG2SI5Ve4peoTYp7yC77JOqLx6aO8uw/YZ2wLvHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ADXVoqPT;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F72606A327
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F72606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ADXVoqPT
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so48214365e9.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795701888; x=1796306688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
        b=ADXVoqPTS7f2hhsnwR3CfjDkbVY+bg+RLlNZcU6eV9k9hgeSl+Q7T9M20LufkZ7KoK
         a+3sSfQKhEtv3dcZxLtrwgCzz3pC51SvgoYRDTXGK/249wuq+QUL0XSYDGm9SKiAuFdF
         xPjktJNSOB6Lrt43/g+wE3cqskASEowN+2zbdXCmD4oivLbfJRaUE9knaa5dbe890i6v
         10ghwsXMMrJ76SjF7yTcDBZ8sWHawBtmMI30JAZd2s9tOgmbiqPH+xn2EXDSfWNwh/W8
         TzFrmIXm905c9MO9oWsMnANrmHi6oM1PV5zRF5LcFSt1RO3GztJYNNAM/9t1uC/NYep7
         TR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701888; x=1796306688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
        b=Etw9ceIQ2r5TUuWlb0LK/5c3dPZ1udt+EAqGx+2sgCrP26OiKPzYvKV26PEpHGnWv2
         eFrLTP8RNMCJh5DRhf/98kOsbUgTSRsC7gO79IVujqxnbJqs3eogYD+48xIJ91w/V9r+
         1nCeas8JWlyxCGRAUjMYYGTfZY/I/CO7betKUelmpf9947+QAfknnL8a37vnONV9jECW
         JARJz/80yqF7AvkwhwR2qMrKTskdbeB6+7lERi3NhO+LW8Qshz023to8OJGnUlUpPBaX
         cZBZCkshGIcu+SXCwAt2BHuYqX8DHTwnXD5NZJX5YyR3y8egniXIWmCBA+xaUF+Ky80+
         eJxA==
X-Forwarded-Encrypted: i=1; AL+hErEa57mjiGFoPQ0hgsF7cQz7O3J54/YJPce3ALto4tUMuEvS7TL9gZHlwEQYhyg7pBtLHyQA4BipLjyy@vger.kernel.org
X-Gm-Message-State: APuU4Z9FTBHuumeCeycec2+5AiaLLdueVjaYRqKdWCnqENi+jaS/uxKw
	VGQVQpETMygtcpuYy1JQ6T6nCA09gM9ffW+I8lJzoSmo0MMvizDDB7PhEhvDnVs0E0s=
X-Gm-Gg: AZFdTZetS+EQL4Cl6xYBuVy1sfRwR2xSN1RXH31bZ/VW4e4Xv4S6RtHuRudKEcPFZSH
	r1ZDE5pTVUsfehTmagJZcMrMI8e/rXFQEfFon5ZbvPtn5HFImMVTUmU8jClCmQmTURAHCmEwrVL
	1w5H6ZPe5dxrOgNjOekAJubf129535Vc0TR57RnNd5ZBhHASoNQpuEfW0Uk7u5LkcIypUhJMXd5
	iUKbcvjCcXOT4xhBQfsxVFcqtTjLgGVYKqaR9s8JolDNABSBhuQ0HB0MHB/gu/v3OTU49Exg0NF
	asob6YRMNe3g+npCZDaE8LcaGHhEEI+tcpI+sm4zaCrhTGVBQcT8sXhfxsz+HjpP0bhvNGovrer
	Z+FKZ68dJCdFUeh7V3iUFTdugOiEC50DiQgbQ7OG2Px2Hd1dH3BfQun6GKfhC8qvuL17pTO8KVA
	Obvas3R6U4RqsoDygIjg8h/ypgMZXuuY3NFn6uRdp0EXN4f1HikHsjzY+2BcdtXl2UoTGojkmig
	1DtVVo27PxqVDaX7rbfP+BkIUhcVMk8TLhJMTObuCvkO2ISQ96HNrjB1eGyju6teWS/3Zc3Mi7F
	UDRa3WePiZQz2HBO6OTtY3YzzbDmkxelZ+V65lRT
X-Received: by 2002:a05:600c:8b83:b0:4bb:60da:56af with SMTP id 5b1f17b1804b1-4bb8893053dmr381871055e9.25.1795701887195;
        Thu, 26 Nov 2026 06:04:47 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm736831665e9.6.2026.11.26.06.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:04:46 -0800 (PST)
Date: Thu, 26 Nov 2026 17:04:43 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>, linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awg8e0zM2DL87AKP@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
 <awam4std0Zifdn9k@stanley.mountain>
 <awan8mSx5cbzXzJ7@stanley.mountain>
 <20261126133744.219929-A-seiden@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126133744.219929-A-seiden@linux.ibm.com>

On Thu, Nov 26, 2026 at 02:37:44PM +0100, Steffen Eiden wrote:
> On Wed, Nov 25, 2026 at 12:18:42PM +0300, Dan Carpenter wrote:
> > On Wed, Nov 25, 2026 at 12:14:10PM +0300, Dan Carpenter wrote:
> > > Let me add the s390 maintainers to the CC list.
> > > 
> > > I considered doing it the way Sashiko suggests but s390 doesn't have the
> > > __vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
> > > not the same so, either way, some of this is going to be specific to
> > > arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
> > > across a reset.  The s390 maintainers could probably take the selftest in
> > > patch 8 and modify it for s390.  :)
> > > 
> 
> FYI: the arm on s390 KVM in the current upstream state has no idea what
> SP_EL1 is :) 
> 
> > 
> > Actually, never mind.  This can be done in kvm_reset_vcpu_core() like
> > Suzuki Poulose suggests.
> >
> 
> We share kvm_reset_vcpu_core() as well :) 
> 

Yes, Suzuki Poulose told me about kvm_reset_vcpu_core().  If I put it there
then I don't need __vcpu_assign_sys_reg().  Thanks, though!

regards,
dan carpenter

