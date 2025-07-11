Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873792A8C1
	for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244569; cv=none; b=EQWPZKxVt0g3+GvUuAQuxddwaQViLV06joGrrZrzbeFoLtHjjuJa25L0W4y+YqV2Q1jWR/FaC7ZX+lIn8Nnten26Piz08WS9tG2uUTM7ja+fBSoe03CgQ8x+W5AU2Sj9jt3zwMC7tp4JpHbz8odkdT1ZI3zH4wWLFEIltMeM8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244569; c=relaxed/simple;
	bh=Xkh+vWbuylyauziOzIzlKZxgnENPwPl00sBQxdB+ihg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9QcuaM87XYMOyldP76fBR7fO9HjQtqA1iE3m9EpjLA0awg2WhchUuZgJzBhvANX9UmW/iG8UMABy1O68/klawsc1Tkn22WHdsGnhMCaIHDYix7sWEKOKkYGG95KkS24+nIEnFaE2LdC4Q4VTdwfPX8F5x8Sd3bQK5Znn1cSu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V2Z1W6T5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2Z1W6T5"
Date: Fri, 11 Jul 2025 16:35:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752244561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grsYows+9sHElnPNNTmSBrFWiRJY83TUzmMJ77We0PI=;
	b=V2Z1W6T57gXqBL7P47kpAxJKjUb9twcwWPHGIJmXcPG5ZoU+rxoKrdN4pkXlQZ3VbFmDqT
	dh18/YI2V2ixNx1Nn1GKxyWiDDf2S4jhhecmukG/j/K3En+iyWOiTYEHMl5YFwGrtgRb/k
	u2yoV9Lr7ZFqZlAGHzN/orAyb9x2K2o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, eric.auger@redhat.com, 
	lvivier@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, 
	david@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com, shahuang@redhat.com, Boqiao Fu <bfu@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 07/13] scripts: Add default arguments
 for kvmtool
Message-ID: <20250711-357d520bb64154cbe119679b@orel>
References: <20250625154813.27254-1-alexandru.elisei@arm.com>
 <20250625154813.27254-8-alexandru.elisei@arm.com>
 <ce92db8c-6d26-4953-9f74-142d00d2bc2a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce92db8c-6d26-4953-9f74-142d00d2bc2a@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 01:32:33PM +0200, Thomas Huth wrote:
...
> > +function vmm_default_opts()
> > +{
> > +	echo ${vmm_optname[$(vmm_get_target),default_opts]}
> > +}
> 
> 
> This causes now a problem on s390x:
> 
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/10604334029#L591
> 
> scripts/common.bash: line 56: vmm_defaults_opts: command not found
> 
> ... any ideas how to fix it?

This is fixed by https://lore.kernel.org/all/20250709085938.33254-2-andrew.jones@linux.dev/
which I just pushed.

Thanks,
drew
