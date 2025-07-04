Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317182BEC20
	for <linux-s390@vger.kernel.org>; Fri,  4 Jul 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618527; cv=none; b=pqiFm53lnMYAHTVva4dnegyIO8jabRAkVW8DgZt8wxek+4l/PAkWriD2T6+QeNPYs+8feEn9D3n6sQp3wAw27oFNckNXisi57aoo8+n6ru/iB03VYaKEt1TziGsp2i6bzAkimkYEQ00DWl3gnoxgU6PahHqhDOn7j0DZ9yH9y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618527; c=relaxed/simple;
	bh=l+Iq4K1uoyGqCoRNhi5p2zA2usy7g3Wf+XI25md6eEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYgo2l6n/DdmnY4EwR2Ga9wUFS7bzgtosbu5uhrS0Ahm6NX4DvhY1UrKSRtocZd3dBkv1W3vQe6XG1jayJfB4wHDvU1BUJ2kCRkPRZ0QEfgFKoevd5nlw29TKQ9mXVRs4Kb+cplLVQONVtk86gzcqxToKKvtNxgSywk9VbvZi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=urgOd1aZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="urgOd1aZ"
Date: Fri, 4 Jul 2025 10:41:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751618521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PnaSGtLpzW5dir2K2BrEyMD5UpUXb/WyC+H8PujG7Q=;
	b=urgOd1aZHEwU+HOxLQWi5GvXP2k5P56SbDD8NDOc49RcISR8mr1EFZbcesPVRdbN1m7oAh
	kUPg88LuxHtjy2dAyNloPJXePywzyt89TRKSuW8cK4SqhYp1NAMI2dsOwHn9bbuihdkScS
	hMJrMblwswPleTxW+/PJzf6Xl6mDONM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com, shahuang@redhat.com
Subject: Re: [kvm-unit-tests PATCH v4 00/13] arm/arm64: Add kvmtool to the
 runner script
Message-ID: <20250704-ca0e2f54c803b35428c13e0d@orel>
References: <20250625154813.27254-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625154813.27254-1-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 25, 2025 at 04:48:00PM +0100, Alexandru Elisei wrote:
> v3 can be found here [1]. Based on top of the series that add qemu_params and
> test_args [2].
> 
> To goal is to allow the user to do:
> 
> $ ./configure --target=kvmtool
> $ make clean && make
> $ ./run_tests.sh
> 
> to run all the tests automatically with kvmtool.
> 
> Reasons to use kvmtool:
> 
> * kvmtool is smaller and a lot easier to modify compared to qemu, which
> means developers may prefer it when adding or prototyping new features to
> KVM, and being able to run all the tests reliably and automatically is very
> useful.
> 
> * kvmtool is faster to run the tests (a couple of times faster on
> my rockpro64), making for a quick turnaround. But do keep in mind that not
> all tests work on kvmtool because of missing features compared to qemu.
> 
> * kvmtool does things differently than qemu: different memory layout,
> different uart, PMU emulation is disabled by default, etc. This makes it a
> good testing vehicule for kvm-unit-tests itself.
>

Merged. Thanks
