Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAD1EEA4C
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934978; cv=none; b=EGlTSWi4u8Vwm4FAJWK83jQBplXw19a0SOmzaBJndAjGTeAv1ZQonFdPD59g6n5dxev9AV7IMegGYuzN+VNTZhclohDSLvcfY+GP6ELosDIYGWIl3px9xNqvYyqfGTQH2kCdpSE0y8ct2T7/RDwmSMM7UtXI1bJJxkCtBP/d/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934978; c=relaxed/simple;
	bh=cy33F4U8R5WxJwAeq6MUnvjwcIyqy5N1555cCjhlzco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsMalEuX6iyRyhImcVBJdpU2shJs8NgB1fu61QnDimc82vwPWT0IqsGtFk0eOl4f7Ozji4TEJpl1RKYLSOLrkRTSDubGYHpgy+6DgOzfQp5nKHoA9xdi17t0WV5CgXHX46psF5rYFk/RwMrdd5dQfW67cSv6IVuQg9WhzvP6+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D6E12FC;
	Wed, 15 Jan 2025 01:56:44 -0800 (PST)
Received: from arm.com (e134078.arm.com [10.32.102.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AAD23F51B;
	Wed, 15 Jan 2025 01:56:12 -0800 (PST)
Date: Wed, 15 Jan 2025 09:56:09 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
	david@redhat.com, pbonzini@redhat.com, kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 1/5] configure: Document that the
 architecture name 'aarch64' is also supported
Message-ID: <Z4eGOfDjz7RS8pBq@arm.com>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-2-alexandru.elisei@arm.com>
 <20250113-0fe04c6089726d1d06a254ec@orel>
 <Z4aY2AKSaxKDY5Hq@arm.com>
 <20250114-10fb4c9302167ef202e98713@orel>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-10fb4c9302167ef202e98713@orel>

Hi Drew,

On Tue, Jan 14, 2025 at 07:39:49PM +0100, Andrew Jones wrote:
> On Tue, Jan 14, 2025 at 05:03:20PM +0000, Alexandru Elisei wrote:
> ...
> > diff --git a/configure b/configure
> > index 86cf1da36467..1362b68dd68b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -15,8 +15,8 @@ objdump=objdump
> >  readelf=readelf
> >  ar=ar
> >  addr2line=addr2line
> > -arch=$(uname -m | sed -e 's/i.86/i386/;s/arm64/aarch64/;s/arm.*/arm/;s/ppc64.*/ppc64/')
> > -host=$arch
> > +host=$(uname -m | sed -e 's/i.86/i386/;s/arm64/aarch64/;s/arm.*/arm/;s/ppc64.*/ppc64/')
> > +arch=$(echo $host | sed -e 's/aarch64/arm64/')
> 
> Sure, or avoid the second sed and just do
> 
> host=$(...)
> arch=$host
> [ "$arch" = "aarch64" ] && arch="arm64"

Yep, thanks.

Alex
