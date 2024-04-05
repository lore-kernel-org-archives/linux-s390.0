Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCC16F851
	for <linux-s390@vger.kernel.org>; Fri,  5 Apr 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327501; cv=none; b=nBFxke6uRHysQKRX2I4eTJD6xR9OjcG6YcV198i9GtEWwxinD3PD2FlEmqhAMzjQz4AZ+bnH1e7j6qZafVyWDiyFEtydeUQUwLu4PyS3ZulvHkaYXKymwJNl7bGoNSZ0wmnhepliPfXh8Lp6g7jdboaTybaoOSwzqeVeTF6DnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327501; c=relaxed/simple;
	bh=dNygJby67Cdvcvl0y7n21FxTGIpVy868gYWkMjcWU6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPW7CsG/STSAGWWXZkfAS/13RjI9yu3QxyumvnayOdziqpPQ/dbbM3H7jK9hEs+fWAgxHEiLklVw3xhys8pPTAjkc/rDmlksJU8HQ7J8nqYsRycXXX8lN4eulE+OGKmWTIobuBs4gaewlb8WqGWpzeOSobH/Oo0jLDdlBlWTE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GErPDrev; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GErPDrev"
Date: Fri, 5 Apr 2024 16:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712327498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/xOkaTxQ2aUEU42TOlQF76gpDIp/PIEB5q35o4B6vI=;
	b=GErPDrevJpRO8nnYKRAF4gRl8e52qeyAMUbhmhoExGHDdDbI0beoLh2ifwbxpZ0uzLAToy
	8aRj7nXqSlADLwnz5yRlJKohEZXXiTiFy7uXtag0GWkT0CXU8VMaCu8xGU3K19dSFEseOF
	nziKaWk4K3NWS26sMPRWX8oPWfUaghk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Nikos Nikoleris <nikos.nikoleris@arm.com>, 
	Nadav Amit <namit@vmware.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Ricardo Koller <ricarkol@google.com>, rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>, 
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests RFC PATCH 10/17] shellcheck: Fix SC2013
Message-ID: <20240405-0a2cfafb045613943c8d3162@orel>
References: <20240405090052.375599-1-npiggin@gmail.com>
 <20240405090052.375599-11-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405090052.375599-11-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 07:00:42PM +1000, Nicholas Piggin wrote:
>   SC2013 (info): To read lines rather than words, pipe/redirect to a
>   'while read' loop.
> 
> Not a bug.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/arch-run.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 9dc34a54a..e5750cb98 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -487,7 +487,7 @@ env_file ()
>  
>  	[ ! -f "$KVM_UNIT_TESTS_ENV_OLD" ] && return
>  
> -	for line in $(grep -E '^[[:blank:]]*[[:alpha:]_][[:alnum:]_]*=' "$KVM_UNIT_TESTS_ENV_OLD"); do
> +	grep -E '^[[:blank:]]*[[:alpha:]_][[:alnum:]_]*=' "$KVM_UNIT_TESTS_ENV_OLD" | while IFS= read -r line ; do
>  		var=${line%%=*}
>  		if ! grep -q "^$var=" $KVM_UNIT_TESTS_ENV; then
>  			eval export "$line"
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
