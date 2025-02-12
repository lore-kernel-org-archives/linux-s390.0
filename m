Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731F253B49
	for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375349; cv=none; b=JGVCZthL822InAXZq6dpw8wNRK3+groejHJJRDs9HqREEoYsZrKyY7/1LqvzIUjgtdPePEhVFbSmk2qj9ykfRKOB8hjedcNwAp4A/ZFm14s3ZlylK7zgbmhCvZOcvFD8Ox31T7X2o1noOj1kNYEXF6wKl6I72WWMrhITkVvprNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375349; c=relaxed/simple;
	bh=OxkzckJ894uEJz7kftdcKxjWCvJaHuQolxSxlT36+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9CzkvI0yg6VxKJlCNEY2XicyyH+HIaRC5372YQly1aVypoDXfcpupJfpuMsmUqRjuDiJfqbfWq+ZCh9qsy/miIkYR+IlGgA77GAmrDwv0vsy4qQJq7niLCUyL6X5abyjQcbFmk7cggXpb8N2dLCixbalhexbP4mIh7H/NRLblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/OgCsn7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/OgCsn7"
Date: Wed, 12 Feb 2025 16:48:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739375333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vmg0L/g3+q0yTaB9LWuHIF8QkwBzZd4h117MfIen5LQ=;
	b=c/OgCsn7kQs98DTIPDKyRY9IWuczp96fsZXGkUJNCxyBQ3Vuz6s8GWJ62djGUbxKpC1yWk
	I7zWfhyo8zlAy4AiQFrkZVib9LGSyoTypCUCRw8hliUvQPNi40nHB0vTSXQqKFW9IEIjL8
	Z5yFO3yLd2b9eklxpPjom4HHbQciLf4=
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
Subject: Re: [kvm-unit-tests PATCH v2 04/18] run_tests: Introduce unittest
 parameter 'qemu_params'
Message-ID: <20250212-8427334ce25d709f70c4053c@orel>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
 <20250120164316.31473-5-alexandru.elisei@arm.com>
 <20250121-82874afe4e52c828d21e7da2@orel>
 <Z6yk48JpsYKHwFye@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6yk48JpsYKHwFye@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 01:40:51PM +0000, Alexandru Elisei wrote:
...
> > > @@ -80,7 +80,7 @@ function run()
> > >      local groups="$2"
> > >      local smp="$3"
> > >      local kernel="$4"
> > > -    local opts="$5"
> > > +    local qemu_opts="$5"
> > >      local arch="$6"
> > >      local machine="$7"
> > >      local check="${CHECK:-$8}"
> > > @@ -179,9 +179,9 @@ function run()
> > >          echo $cmdline
> > >      fi
> > >  
> > > -    # extra_params in the config file may contain backticks that need to be
> > > -    # expanded, so use eval to start qemu.  Use "> >(foo)" instead of a pipe to
> > > -    # preserve the exit status.
> > > +    # qemu_params/extra_params in the config file may contain backticks that
> > > +    # need to be expanded, so use eval to start qemu.  Use "> >(foo)" instead of
> > > +    # a pipe to preserve the exit status.
> > >      summary=$(eval "$cmdline" 2> >(RUNTIME_log_stderr $testname) \
> > >                               > >(tee >(RUNTIME_log_stdout $testname $kernel) | extract_summary))
> > >      ret=$?
> > > -- 
> > > 2.47.1
> > >
> > 
> > Hmm, I'll keep reading the series, but it seems like we should be choosing
> > generic names like 'extra_params' and 'opts' that we plan to use for both
> > QEMU and kvmtool since they both have the concepts of "options" and "extra
> > params".
> 
> I'm afraid I don't follow you. 'qemu_params' was chosen because it uses
> qemu-specific syntax. Same for 'kvmtool_params', introduced later in the
> series. Are you referring to unittests.cfg or to something else?
>

I didn't like the renaming of opts to qemu_opts since both kvmtool and
qemu have "options", so it seems like we should be generalizing variable
names rather than making them more specific. I see later how there may
be a need for qemu_options, kvmtool_options, and unit test
cmdline_options in the unittests.cfg, though. However, here, it seems
like we could still use 'opts' for the variable and just use another
variable to determine if we parse qemu_options or kvmtool_options, since
there shouldn't be a need to parse both.

Thanks,
drew
