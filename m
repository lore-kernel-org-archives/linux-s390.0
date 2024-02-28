Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1B29403
	for <linux-s390@vger.kernel.org>; Wed, 28 Feb 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121794; cv=none; b=UPNbr+h/v+frqICuEVUMFoE5v3o5K09tf46xRHv9Poz+NCAA4IYYpKNvZKkVVEEZgiTk4q0eZf+kJF3OcXB4b7t0NrV3Bb5MHoCyGQY3vo3xFjZvNtG4bRL2ZAr66nik6XXhUTCwJLDSDZiKFnboo58b/3ew3dz/5DZCixRSZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121794; c=relaxed/simple;
	bh=pUBc2R2YFf7Byy+OLL+SAPV2HRavjbo1kEXGsmSELxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQiMa77+3v9JLaBszZWyceaJFXaahUqKtkzsGzjJIftoSLUhgk3AVaT3TzX3cXKwqXzJgz8vYV4D4kBumEXR+TvrxqPXcteDe6caMLvHxYK7MEdNZCv0r3wEGnocAK6w30qMzoGbVWCmHMKVqTGJuNrxFdEb17sjjXBqMC/VN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FGKQp71c; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FGKQp71c"
Date: Wed, 28 Feb 2024 13:03:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709121790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q89KG4hdzw91oeVn8moMG49vjA7FBhdRABUSEGGkg0o=;
	b=FGKQp71cnpb+ff7fwhUaOxfcQi2pU2AQTOhrS+iK+ckkJXe7l6AiLbVdHDWo/naazejElA
	Ux9yyzoomusx4EMtfjcFSIY0eYRjXld8bGDHF3Ln7lkq/9YOCa72PslC9+oDscM+s5IXXn
	AYJry5YoWg8egA6yIUcnHPPN4xj/v1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 24/32] common/sieve: Use vmalloc.h for
 setup_mmu definition
Message-ID: <20240228-9d47975f00d02c47c9b9368b@orel>
References: <20240226101218.1472843-1-npiggin@gmail.com>
 <20240226101218.1472843-25-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226101218.1472843-25-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 08:12:10PM +1000, Nicholas Piggin wrote:
> There is no good reason to put setup_vm in libcflat.h when it's
> defined in vmalloc.h.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Andrew Jones <andrew.jones@linux.dev>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Nico Böhr <nrb@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  common/sieve.c         | 1 +
>  lib/libcflat.h         | 2 --
>  lib/s390x/io.c         | 1 +
>  lib/s390x/uv.h         | 1 +
>  lib/x86/vm.h           | 1 +
>  s390x/mvpg.c           | 1 +
>  s390x/selftest.c       | 1 +
>  x86/pmu.c              | 1 +
>  x86/pmu_lbr.c          | 1 +
>  x86/vmexit.c           | 1 +
>  x86/vmware_backdoors.c | 1 +
>  11 files changed, 10 insertions(+), 2 deletions(-)
>

Acked-by: Andrew Jones <andrew.jones@linux.dev>
