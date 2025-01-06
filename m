Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40B159596
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143695; cv=none; b=Nj321OwlSG42CNpy8uR+wCGn0PHDbHL+RTMWYADjNS0B9BuONPtrCxxwSNg9ik7dhrAE1UIsKbqLahugLA3Yayl6jc9W+JKr8MIZ63h3y+ouv4JV08jUUvpaBL7IfIcXhdlJld0mMEmaQCCRHcOpqeKnUrVZXpcO3x8r/G7UbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143695; c=relaxed/simple;
	bh=DkJ/AVZDr+223bh7T9SGuJvD3BwYN7Ayn7jY/gRteDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbxZgaB4Ou/sr7EwThE3ykuLb5+tqgiyWvGxKpuW70De+ABQZNP3LuSlkVA+ZITEYBOsV1YO3SnVyaPFnv45pSq2IRtRiAEeFCtnLa/tFHswUvixpP767gPw5IA50TuF3KrGL+IOPX14kE9IUET5B0Cr5P5Vha8ZFiF7WIQxeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TO8KuJHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO8KuJHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736143693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECj6xbOSydsrQ0h3y60hbN6oNhcXb1gzQeH/Gov1IA4=;
	b=TO8KuJHzpvch5coStrHWTHkA7LQm0yWZ8BgYSFTmDjBb8HCVtVpu+wdCy+aQ6tj7MSE/Ok
	6/AKG4T+3VutOVIejus7g/g/M9OSIK+B7Ee1+9+M/MQ5QHZqIGKgylWbQ1oiraSSz0pbva
	BquSlgCOpRDmaZ1rXYDcBUnZBf3I16c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-jEM1C5x0O9uGyYUyawzKbA-1; Mon,
 06 Jan 2025 01:08:07 -0500
X-MC-Unique: jEM1C5x0O9uGyYUyawzKbA-1
X-Mimecast-MFC-AGG-ID: jEM1C5x0O9uGyYUyawzKbA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A94B91956057;
	Mon,  6 Jan 2025 06:08:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 439E5195605F;
	Mon,  6 Jan 2025 06:08:01 +0000 (UTC)
Date: Mon, 6 Jan 2025 14:07:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 0/5] elf: Define note name macros
Message-ID: <Z3tzPXorz6hzkvy/@MiWiFi-R3L-srv>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Added a macro definition for each note type instead of trying to
>   describe in a comment.
> - Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

The entire patchset looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

