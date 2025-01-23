Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEE288A2
	for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647658; cv=none; b=A/nyZVsNhMcoAQMgCACxz0vyMnXVHwXCsgrjVH7FzW1Y4dEx0gnBiQvxmDsjtOHnSBQv8eZvO1Sk2TQ0ld0HeJN/Yjgfo3ZdvkSWPLPap9j4Yt5xJ3A7FsEJYFKWO92JZTwLpWkNd8wczdAm7ZcE6hHm6BWhktdipRlPQRWVS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647658; c=relaxed/simple;
	bh=8OVl4dJBNzMIyEkstvz6Eo8ahPGFATcZ1oOJhXZRKIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j06A0QPjcF18oIBVeYnxHJzfTnQxmdENCxTfV/M2R5oayJ+VprPqkd5gV74GwjEMVKqbJ1wrh6uMgXe38GeJpj/nlGug9OpeFqZiCGm7su7vOVOyVgO9Xx53j45VsNbmD9hVARsxbWzdgALnRKXE2SNboDH23XiMucWJWeTzUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=shOObFcR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="shOObFcR"
Date: Thu, 23 Jan 2025 16:53:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737647644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0hjrjFJ/ozZH89y4XWSBwoxstcKne12SMD0/oS4m2WM=;
	b=shOObFcRnqmPGumC+S+CCw2ZitX5myqi/7q4xT340l4Io42BVxZ4VkdOWBYIJ5jReaeIxO
	b63ldlzoSBnWTUa6eky2tJVgCyM4IkMxtmeyD53EJVtbF09CeeeTmxRMHZOKFSglHvuvig
	3JwVyJx/LwHu65D9VF88YpR25iZdoSQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v2 16/18] scripts/mkstandalone: Export
 $TARGET
Message-ID: <20250123-9258916e6005692470d95762@orel>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
 <20250120164316.31473-17-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120164316.31473-17-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 20, 2025 at 04:43:14PM +0000, Alexandru Elisei wrote:
> $TARGET is needed for the test runner to decide if it should use qemu or
> kvmtool, so export it.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  scripts/mkstandalone.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> index 4de97056e641..10abb5e191b7 100755
> --- a/scripts/mkstandalone.sh
> +++ b/scripts/mkstandalone.sh
> @@ -51,6 +51,7 @@ generate_test ()
>  	config_export ARCH
>  	config_export ARCH_NAME
>  	config_export PROCESSOR
> +	config_export TARGET
>  
>  	echo "echo BUILD_HEAD=$(cat build-head)"
>  
> -- 
> 2.47.1
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
