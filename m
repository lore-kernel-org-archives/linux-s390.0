Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA37E591
	for <linux-s390@vger.kernel.org>; Wed, 24 Jan 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107139; cv=none; b=EDqi7dNnrtOJXML8Fp3ESX6KtaswHRq+XwGOh2aGXyr95IHf2r3nIn0j3M7U2CjKJsTlvIdE5cLDMfySN8i3c+bUFIuDOOAbYp9fWmcl+DJOXm856SBPLSvy9rXf91jX1Z/dtEXP5FyfUSaKGzYt40qdLqFEgvhrtcCJlLutpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107139; c=relaxed/simple;
	bh=pok9Rb9/rau/3FIlKw2abb93LnnTtE0ZjzrxlzDpf9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9/JYTk3XYgihhPvdaeuasutfHLe3j+2RHQPeTPQ9otiUOj+fvjWPxcEEPiIXgZU2DJ+ac5KjFynTBKpISSU75Mk4tBooY5E6ojX04G1X/SKxGReFEODy5+iH0Av4gaEXouTukV2CfDJ6gR43YdQsCq83YSWhExOqLEtkHvkoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyxDTzl5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyxDTzl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706107136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls80tWWITZqF3iJAPsDuzCkVtKDTZBr/hmM0JE5RG5g=;
	b=dyxDTzl5xk2dMTJrcHKGK+JOS+yruA969rBXMSvFaraMxrtGHizQC422CRWzNoyyT1YJ81
	+PCviL7FpfLKhhnbgjUaTDHjjvsFHk1Hj0ocg+bA2163Rwo4LE30n1UiuupPxyrYTPlSIf
	jOLZXpBvlvuhb8SHE1yW7qG/bmkYYRI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-hw5KzothNAWkK-1bR3SVuw-1; Wed,
 24 Jan 2024 09:38:53 -0500
X-MC-Unique: hw5KzothNAWkK-1bR3SVuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 254953806622;
	Wed, 24 Jan 2024 14:38:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B49AC03;
	Wed, 24 Jan 2024 14:38:51 +0000 (UTC)
Date: Wed, 24 Jan 2024 22:38:49 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 10/14] sh, crash: wrap crash dumping code
 into crash related ifdefs
Message-ID: <ZbEg+aoWKPww71gW@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-11-bhe@redhat.com>
 <27d8aa3a9e604a7e45c87b7fbc5b1ec2a63f03e3.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d8aa3a9e604a7e45c87b7fbc5b1ec2a63f03e3.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/24/24 at 09:13am, John Paul Adrian Glaubitz wrote:
> Hello Baoquan,
> 
> On Wed, 2024-01-24 at 13:12 +0800, Baoquan He wrote:
> > Now crash codes under kernel/ folder has been split out from kexec
> > code, crash dumping can be separated from kexec reboot in config
> > items on SuperH with some adjustments.
> > 
> > wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery, and
> > use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
> > in the crashkernel reservation code.
> 
> Comparing this to the patches, it seems you missed the first word
> "Here". Either amend that or write the word "wrap" capitalized.
> 
> I would omit "Here" as it's not necessary and just start the
> sentence with "Wrap".

You are right, thanks for careful checking. I will see if I need repost
to include this update.

> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

