Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8A1DA5F;
	Wed, 30 Apr 2025 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971718; cv=none; b=bDnDMDL5qwDWRY2tftdELmchX4OXci/bAP04z1Tp4TSrzAtY2Kgpkq0nVvqL6YuQ7/615lMK/bWTjEO2KnCpXh4YWaWTyeayO0NIZlsIePz6humLXwLkpm8zDoTW25VE+NSm9AHFlMVr/TUbecNuzF3agADRN/JtxSwGoc9n45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971718; c=relaxed/simple;
	bh=dx7P+R9PB1dmUgAtd+luccp+t59oxVb+zJy/W2y6J9U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jRMEefT5zHnd5YUXarLT+L8x77aMiSe8ScT4jP/kUrbClR33JyNPspfAvoogNMuEUZYePVwM1R7tkTS6jhY7CmP97yB1UJTELpyTb98h3YCofZiDeM9KpBhziuWSMLN+7giuu9fPlf/EsphnzU59DQF/E+iOZ3KDCZApSWPDJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VlLxqEtf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VlLxqEtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9855BC4CEE3;
	Wed, 30 Apr 2025 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745971718;
	bh=dx7P+R9PB1dmUgAtd+luccp+t59oxVb+zJy/W2y6J9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VlLxqEtfaxvhdaSdxESr7mYnlUNxhB/KeoWQWnSl4EAwVd0nBdZei++vmTndMJOIR
	 cAxWUNBtRDCeNnWst2L60Ram/TfBbyJFY5QaBpdjoQz7xhq8hjJT0w0z1pTOTM6ISf
	 KfJbjuuDLzltrT3m6GO2t11skpIApnSVAIGGUDWY=
Date: Tue, 29 Apr 2025 17:08:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens
 <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-Id: <20250429170836.bcd25bcbe25d4f3d436d9e39@linux-foundation.org>
In-Reply-To: <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
References: <cover.1745940843.git.agordeev@linux.ibm.com>
	<573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 18:08:41 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> +	__memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);

pfn_to_virt() exists only in riscv, s390, m68k, loongarch and microblaze.
