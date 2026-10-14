Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98244E01E4
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980861; cv=none; b=a3zmsE+FoizFOQGx+URYPIr80n87S/gz4iW7bchQZP579+Z4OEqs45QcH7qKqSF2/4smwbAixVLdvtjFcyE2jYEseotHdJOZ2X74PnxyTp0wp9ipNDI0srNW0B1eRi0AL2Krn2tPr9I/WP2vNEQePH06PPSNeodn/iSr9LR6XSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980861; c=relaxed/simple;
	bh=t+tXOJgINuHz5ua6C+34HLQge1ta50pjf8UE+NV3Ad8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRPURdzqOeyqdXw9NWx/n5Dy7hN3ugNNzuZD+DOghrEE5aeEJj1gt77XlsAukuYjdPF6Ga4Uux+LgARZo7yEN9sfYeLURA+AR05LocKc1OPisH7vaahIhRqwLWwYuIePqtzNMhxdusX19GUqQFz+dY/N1/PyKbpb6IgpYBm/1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKaI3MWJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKaI3MWJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48870973bddso2431194f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791980858; x=1792585658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bU5WoXEdNTnz+BAlcIBVqmgTpCbqy4PVyKMuyqbaZGE=;
        b=QKaI3MWJ0JVmVSc1vGOVIC/GF97hRyT3l0VbMBfDtGdJck/2HBAOSMI/EpAmt6oiXL
         Y6yzlzIqiy974y1UWonOY1sjE1KH+nSdpUsA3+0pvq18XIk7eGmEEeGiop56ke+uaCAb
         ho3DjA0gXqIi/8TfhsI8VFrcCbq9xKAS4tqB7Gg5PPuCYFUjmzjX0Otg4AZ5CixfyP0k
         +zbsPtMWLGjZ9DZSq2t16T7hoTZN2xWMWvk8eHx9bYxvm/IRzX4+HIllQmW9z9Yrd0g1
         mdo1IqIEo+U3JOdwdR58vy9/iK4ZgZtQQWJeOzEc5JCyyr/1wW1APWmMtWufefDkg+wl
         hvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980858; x=1792585658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bU5WoXEdNTnz+BAlcIBVqmgTpCbqy4PVyKMuyqbaZGE=;
        b=eVO/CEZG9AC0sZptQ+dnjxA5qCN4FgSZgq4kQaNfoEt2xG2WE1uYVGih/AYrdJ2dOM
         PIjdmraZRjPI54NErEsifcbxLfficcQS99q1Rd4s3crIhGtXF05p8aLzEhFXqXyAErZ5
         wtX4C0lzJJGSs64nCvjw9ngr+S8Fv6C8l4I/c7QPPpEYr5OtbQQ8PL1LF65qBB/B7x/d
         rCuQVHUfqli8r2+w4/4vcp9z6j9Z/ODNzjuEhl/oXGZx+TiR+H2N5T32+xVAql1Fily7
         zd6QK6NT+UoXZIhyFy82PUaWGZ3sYzolWeY1NdvwsCEZjgxjxdWhsm4p0WgveMelZHx6
         cV8A==
X-Forwarded-Encrypted: i=1; AKwUvBwQ/HBCiuhbuDnKGCiW6EY0I4EW4OHaLkEE1JOTeqRYm66Mj6/KsH+yIsel48Rjy1dpcMexazWG7xf5@vger.kernel.org
X-Gm-Message-State: AFq9FYIh7HEjAi0hwMtLehyrcDdbhGRzzUUwfxYen13axwy05TjXNnOG
	iFTWa9N5UmUzUo7+B8bTkjetnIDqYeC4Ri/W0wC0IA3HlQlPCYORhxLr
X-Gm-Gg: AYBFou0Ud7BgiFkKRgYfyIyIBRfpPmPSG5crml9StdmwSiFCV5bAVL8ikZc7Mydbe5t
	o8zyvOrkH2pncme4hNEUuBnDqbKb8wMelg1qCY4SERlRv3nx7RvLFSIZjSd2H79GbWsm1mVOsfh
	0PN4TpQCfRzzD6wS4BNR1zbp7Rx+XwwRteDyd3x01JcIiVFWIpYkay1Vad8U8keRRSiIiBMHYzH
	kaabPWhlcGVh7GE7P8rFAcx2ZGCqzpgGCYm6whhS3eY2bjfzYXHzuXq4VUIIkPVcaiAW02GObUT
	D5t6BEbkdMHtKfcKBB+n9/ByjXCLN0hOJrlR1k/+L++5hdfz5n77phCLCabg9JTW3m76PT5r4S4
	XDdTbaRda62oSO6JSLJJCpwSdy5GhaQve5p/wnDvmL/UMDX342VLBirEjWPE8ZPG/5zWc3cIMr/
	Ugq8J/rXj5s0KP1uA29Hkj599FXU5FAUK6894JfQ7rX3Vxz9I+dU21HRGtCgxeOWs+7SNgWkZAG
	8Gdlmvsc5JcGdRt8fZd/wrv7U0eB6re0V0=
X-Received: by 2002:a05:6000:200f:b0:48c:5669:747b with SMTP id ffacd0b85a97d-48db9465ffdmr35843535f8f.8.1791980858010;
        Wed, 14 Oct 2026 05:27:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaad1sm11373355f8f.17.2026.10.14.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:27:37 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:27:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/percpu: Drop unused output register from
 arch_this_cpu_add()
Message-ID: <20261014132736.10a32cfe@pumpkin>
In-Reply-To: <4907dbfd-3c5c-483b-be25-b0df83af2d20-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
	<20261012114249.2898572-3-hca@linux.ibm.com>
	<4907dbfd-3c5c-483b-be25-b0df83af2d20-agordeev@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 15:24:20 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Mon, Oct 12, 2026 at 01:42:47PM +0200, Heiko Carstens wrote:
> > The laa/laag instructions return the old memory content, but
> > arch_this_cpu_add() does not need it. Instead of allocating a dedicated
> > output register old__ just to discard the returned value, change the
> > val__ constraint from "d" to "+&d" so it is used as input/output
> > register.
> > 
> > This reduces register pressure.  
> 
> Do you know whether the compiler is may be smart enough to select the
> same register for old and val himself?

Given gcc tends to allocate a new register for x++ I doubt it
(and then has to do a reg-reg move to put it back).

David
