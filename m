Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D42233B
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543991; cv=none; b=p1XOL476CEVuEPpiBIcF246fSzO0IUGCNsII9aHIUg4qg67Owkp2Lxn/HUDRqSqhg5BulMgUYgd1LYf+bBclvNHchUy8f5KN5BzJljPA+TkCyG9Fw9TNxxT+/KMeLxgyK806531I7NzQU4vLZimcFlaNDiv84cfrU6HnVa668U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543991; c=relaxed/simple;
	bh=Se+vcpOJuh7aRdTXoefbKbMDy+eWMBL2Bl6ERNfvnFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmzzyKh48TAbl86ERgPrRF4SfM+C/GCJfraGIFX8bgxSiTkExIFpy41+310Mhz82a6MGvITuMd6hMOrR+JMefoQAAiw247Q/IoVZCGzSHe/z2XHDhe0Atn+vFOEA4foxSCPr4LSQVNsXueRnaHOUPOYauAJt/w83a1VZlIYEZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BZ2HHRVx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BZ2HHRVx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a445587b796so404921466b.1
        for <linux-s390@vger.kernel.org>; Mon, 04 Mar 2024 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709543987; x=1710148787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpO1bRxqGHUl4bZn2wivQvLLDkQhKaeBu0WknX2/7aU=;
        b=BZ2HHRVxjni4KOVAnbsO9jpNKdWaWpBaUesRUfUzKC1Uu8VM5FkSwUjYXpqXzDUOgX
         N3vrr+9zmbGXC5La7AVI2sO2hvrcUVPFHaM5OWhH2UklgoY5CAD/iugW8Pk99jnV4kcp
         kx0VIkF9t024ddi0rvY1rVEOqbY3/kojwr+3Ut7PLPtK+fcX/nxHh3q7BzPExyjN5ik8
         WfqeLnPVIwIi+FtteG8KZsz7IMNgJxbVYdTV+cziAMZspgJ5F5Rpa3eGyhAcFV6YpAK6
         MQTLkgF+G0KQaCXqHqiUNyjg6mYUBEnMc+CjaiGmvBpZcqFHDHeArioyilyCb+rIowLo
         WV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543987; x=1710148787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpO1bRxqGHUl4bZn2wivQvLLDkQhKaeBu0WknX2/7aU=;
        b=bqKuCUSvEvzQ/V1ZBgNv36VVHOdHW/sOjdcbArBbskR5a7KaDXD3eJ1dG7lamNBNjA
         nbVp7zrxGx+4mO3SRpWEEp6zw56emUY6HlTK0jydy6ttDjQ0x9D/8GL9bmTps7GoJdzs
         fb3Qx9bUkSHQmMXLhiuLuWjukePcJrG9VSK8a7WtexiMuPcp0MldqSIhZLhmnrqk/O4Q
         nTIp1Dq//dnS+jnCdoCRhTW6GaNWkEDfOJuB5f+VdaXpPzftyBds04kxryAy+X9pKAcP
         iWJtw35kr5a/NxjCs7Yk2KaYQcYSq9F7hk9CoxE3hG9KpPuWdnqewpLDkV9ipGniYwr8
         jAjg==
X-Forwarded-Encrypted: i=1; AJvYcCWHrkmEf2dJt/AIEhDeKtXn40fVXEp9KgkD2FkGm6H8j1RI/nU7Y7bOnruhqO+vssyOX9OcFrouGruWgB1M6fiwCmnRUqgov00E4Q==
X-Gm-Message-State: AOJu0Yxhpp/FCfgnugUIoHieirLJe9tfLoCDJCeu6M2nbUYf3RamQpxw
	DFSBK4LNo/26EAPY2zZyz7ObtvlEiW99WnRcTz4MslKNVMVw3sZ/ZgFykvzN8BQ=
X-Google-Smtp-Source: AGHT+IHBkLHFj5WFEfrPMbcu4indk9Do5CBPsEWA/ISg1HrPVSBD2kmIH2fC68ipsbsm0K9eK2oBGw==
X-Received: by 2002:a17:906:a456:b0:a44:52e8:9b82 with SMTP id cb22-20020a170906a45600b00a4452e89b82mr5777619ejb.24.1709543986706;
        Mon, 04 Mar 2024 01:19:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b00a450164cec6sm1874622ejb.194.2024.03.04.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:19:46 -0800 (PST)
Date: Mon, 4 Mar 2024 10:19:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Nico Boehr <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Marc Hartmayer <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 5/7] arch-run: Add a "continuous"
 migration option for tests
Message-ID: <20240304-e416eb5a087bde2cad5ff325@orel>
References: <20240226093832.1468383-1-npiggin@gmail.com>
 <20240226093832.1468383-6-npiggin@gmail.com>
 <6329dd4c-2093-40c3-8eb8-701d8e8b2ecd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6329dd4c-2093-40c3-8eb8-701d8e8b2ecd@redhat.com>

On Mon, Mar 04, 2024 at 07:17:35AM +0100, Thomas Huth wrote:
> On 26/02/2024 10.38, Nicholas Piggin wrote:
> > The cooperative migration protocol is very good to control precise
> > pre and post conditions for a migration event. However in some cases
> > its intrusiveness to the test program, can mask problems and make
> > analysis more difficult.
> > 
> > For example to stress test migration vs concurrent complicated
> > memory access, including TLB refill, ram dirtying, etc., then the
> > tight spin at getchar() and resumption of the workload after
> > migration is unhelpful.
> > 
> > This adds a continuous migration mode that directs the harness to
> > perform migrations continually. This is added to the migration
> > selftests, which also sees cooperative migration iterations reduced
> > to avoid increasing test time too much.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   common/selftest-migration.c | 16 +++++++++--
> >   lib/migrate.c               | 18 ++++++++++++
> >   lib/migrate.h               |  3 ++
> >   scripts/arch-run.bash       | 55 ++++++++++++++++++++++++++++++++-----
> >   4 files changed, 82 insertions(+), 10 deletions(-)
> > 
> > diff --git a/common/selftest-migration.c b/common/selftest-migration.c
> > index 0afd8581c..9a9b61835 100644
> > --- a/common/selftest-migration.c
> > +++ b/common/selftest-migration.c
> > @@ -9,12 +9,13 @@
> >    */
> >   #include <libcflat.h>
> >   #include <migrate.h>
> > +#include <asm/time.h>
> > -#define NR_MIGRATIONS 30
> > +#define NR_MIGRATIONS 15
> >   int main(int argc, char **argv)
> >   {
> > -	report_prefix_push("migration");
> > +	report_prefix_push("migration harness");
> >   	if (argc > 1 && !strcmp(argv[1], "skip")) {
> >   		migrate_skip();
> > @@ -24,7 +25,16 @@ int main(int argc, char **argv)
> >   		for (i = 0; i < NR_MIGRATIONS; i++)
> >   			migrate_quiet();
> > -		report(true, "simple harness stress");
> > +		report(true, "cooperative migration");
> > +
> > +		migrate_begin_continuous();
> > +		mdelay(2000);
> > +		migrate_end_continuous();
> > +		mdelay(1000);
> > +		migrate_begin_continuous();
> > +		mdelay(2000);
> > +		migrate_end_continuous();
> > +		report(true, "continuous migration");
> >   	}
> >   	report_prefix_pop();
> > diff --git a/lib/migrate.c b/lib/migrate.c
> > index 1d22196b7..770f76d5c 100644
> > --- a/lib/migrate.c
> > +++ b/lib/migrate.c
> > @@ -60,3 +60,21 @@ void migrate_skip(void)
> >   	puts("Skipped VM migration (quiet)\n");
> >   	(void)getchar();
> >   }
> > +
> > +void migrate_begin_continuous(void)
> > +{
> > +	puts("Begin continuous migration\n");
> > +	(void)getchar();
> > +}
> > +
> > +void migrate_end_continuous(void)
> > +{
> > +	/*
> > +	 * Migration can split this output between source and dest QEMU
> > +	 * output files, print twice and match once to always cope with
> > +	 * a split.
> > +	 */
> > +	puts("End continuous migration\n");
> > +	puts("End continuous migration (quiet)\n");
> > +	(void)getchar();
> > +}
> > diff --git a/lib/migrate.h b/lib/migrate.h
> > index db6e0c501..35b6703a2 100644
> > --- a/lib/migrate.h
> > +++ b/lib/migrate.h
> > @@ -11,3 +11,6 @@ void migrate_quiet(void);
> >   void migrate_once(void);
> >   void migrate_skip(void);
> > +
> > +void migrate_begin_continuous(void);
> > +void migrate_end_continuous(void);
> > diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> > index d0f6f098f..5c7e72036 100644
> > --- a/scripts/arch-run.bash
> > +++ b/scripts/arch-run.bash
> > @@ -125,15 +125,17 @@ qmp_events ()
> >   filter_quiet_msgs ()
> >   {
> >   	grep -v "Now migrate the VM (quiet)" |
> > +	grep -v "Begin continuous migration (quiet)" |
> > +	grep -v "End continuous migration (quiet)" |
> >   	grep -v "Skipped VM migration (quiet)"
> >   }
> >   seen_migrate_msg ()
> >   {
> >   	if [ $skip_migration -eq 1 ]; then
> > -		grep -q -e "Now migrate the VM" < $1
> > +	        grep -q -e "Now migrate the VM" -e "Begin continuous migration" < $1
> >   	else
> > -		grep -q -e "Now migrate the VM" -e "Skipped VM migration" < $1
> > +	        grep -q -e "Now migrate the VM" -e "Begin continuous migration" -e "Skipped VM migration" < $1
> >   	fi
> >   }
> > @@ -161,6 +163,7 @@ run_migration ()
> >   	src_qmpout=/dev/null
> >   	dst_qmpout=/dev/null
> >   	skip_migration=0
> > +	continuous_migration=0
> >   	mkfifo ${src_outfifo}
> >   	mkfifo ${dst_outfifo}
> > @@ -186,9 +189,12 @@ run_migration ()
> >   	do_migration || return $?
> >   	while ps -p ${live_pid} > /dev/null ; do
> > -		# Wait for test exit or further migration messages.
> > -		if ! seen_migrate_msg ${src_out} ;  then
> > +		if [[ ${continuous_migration} -eq 1 ]] ; then
> 
> Here you're using "[[" for testing ...
> 
> > +			do_migration || return $?
> > +		elif ! seen_migrate_msg ${src_out} ;  then
> >   			sleep 0.1
> > +		elif grep -q "Begin continuous migration" < ${src_out} ; then
> > +			do_migration || return $?
> >   		elif grep -q "Now migrate the VM" < ${src_out} ; then
> >   			do_migration || return $?
> >   		elif [ $skip_migration -eq 0 ] && grep -q "Skipped VM migration" < ${src_out} ; then
> 
> ... while the other code seems to use "[" for testing values. Can we try to
> stick to one style, please (unless it's really required to use "[["
> somewhere)?
>

We should decide on a Bash coding style and on preferences like [[ and
then write a document for it, as well as create a set of shellcheck
includes/excludes to test it. Then, using shellcheck we'd change all our
current Bash code and also require shellcheck to pass on all new code
before merge. Any volunteers for that effort? For the style selection
we can take inspiration from other projects or even just adopt their
style guides. Google has some guidance[1][2] and googling for Bash style
pops up other hits.

[1] https://google.github.io/styleguide/shellguide.html
[2] https://chromium.googlesource.com/chromiumos/docs/+/master/styleguide/shell.md

Thanks,
drew
