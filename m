Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBFE1272AD
	for <linux-s390@vger.kernel.org>; Mon, 25 Mar 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360125; cv=none; b=AYElmOXeT7sUQcSUaBdFeQpdzWUCQAAxa4zn1AM+1lGO3ejKvcoQSV1hF6Gd8yPcF6iZUjJ9rtIGNrRpyDYEM0WZLWJCB1NU18eG1x5GMai+cJ0LGmceoqsRCgJQi+YKAAVb05nQp3AmDTOnckeaDsIo/zYaHDlYXr2g/Rbq9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360125; c=relaxed/simple;
	bh=z7nQ+fuXBBJwghbwTKA/0pe69mO2YVrSsG63TX2xrh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTByYOfkZU+HrBADkxB/OLYgm045UP3Y7Ftc+OKLHYog8voMmQBvsGaKqwTYZrdprGcpi7yzlbQx8dbHZO4XMW2xTSJKUeYvlvaQgKju8WKOA96iYw+DBojwvlEOfuCWy7qEPki6jpVJFsX5E/oKcRWH1TFDTgkpSXvVetvMQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPhtWb8K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPhtWb8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711360122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzvHsR0swPhNezye8rUpRIe+AmkradciiszFVdBH2qI=;
	b=MPhtWb8KyDxdB6fiI8vHJAa8mI6NCqBX9KQA7x0COKz2SzunoQrok53BXm3shQl7/qw1m8
	bZviS9Cer4iRK4AReK+FGoWpJGMuur/n0biNYYkLj+2809L/MByztHB2XDf8wg8QRrsrN/
	pipV/F19Rzwtx+tBuz2tSkcj9p7xe40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-sGBrjBOZPjWGzkRUL_JyGQ-1; Mon,
 25 Mar 2024 05:48:36 -0400
X-MC-Unique: sGBrjBOZPjWGzkRUL_JyGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0273C0BE29;
	Mon, 25 Mar 2024 09:48:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4782E112131D;
	Mon, 25 Mar 2024 09:48:25 +0000 (UTC)
Date: Mon, 25 Mar 2024 17:48:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 02/14] crash: split vmcoreinfo exporting
 code out from crash_core.c
Message-ID: <ZgFIYuYULrgF1tFG@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-3-bhe@redhat.com>
 <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/25/24 at 09:24am, Geert Uytterhoeven wrote:
> Hi Baoquan,
> 
> On Wed, Jan 24, 2024 at 6:13 AM Baoquan He <bhe@redhat.com> wrote:
> > Now move the relevant codes into separate files:
> > kernel/crash_reserve.c, include/linux/crash_reserve.h.
> >
> > And add config item CRASH_RESERVE to control its enabling.
> >
> > And also update the old ifdeffery of CONFIG_CRASH_CORE, including of
> > <linux/crash_core.h> and config item dependency on CRASH_CORE
> > accordingly.
> >
> > And also do renaming as follows:
> >  - arch/xxx/kernel/{crash_core.c => vmcore_info.c}
> > because they are only related to vmcoreinfo exporting on x86, arm64,
> > riscv.
> >
> > And also Remove config item CRASH_CORE, and rely on CONFIG_KEXEC_CORE to
> > decide if build in crash_core.c.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> > - There's conflict when rebasing to linux-next in kernel/crash_core.c
> >   because of below commits from Uladzislau:
> >   commit 699d9351822e ("mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_init()")
> >   commit 5f4c0c1e2a51 (:mm/vmalloc: remove vmap_area_list")
> 
> Thanks for your patch, which is now commit 443cbaf9e2fdbef7
> ("crash: split vmcoreinfo exporting code out from
> crash_core.c") in v6.9-rc1.
> 
> After this, there are still two references left to CRASH_CORE:
> 
>   1. Documentation/admin-guide/kdump/kdump.rst:
> 
>          Subsequently, CRASH_CORE is selected by KEXEC_CORE::
> 
>   2. arch/loongarch/Kconfig
> 
>          config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>              def_bool CRASH_CORE

Sure, will post patch to clean them up. Thanks a lot.

