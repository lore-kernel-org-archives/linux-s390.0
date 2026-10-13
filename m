Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517363806B5
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932150; cv=none; b=OhcUeob905ppOrN1QWBVfta1bOjCG9EdiD07dZJX5EYimFNJbcZzV0k1RctMXAQ9POXgKthxnXZ3zhvV2U7cJW2qmEtuBBql93BtSTfAz/K5vq2OSKRO8d8cYSh/R3KGSXWf+QuCsefJKBLozFoJGAWqMnhsJv4gu34TckgHcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932150; c=relaxed/simple;
	bh=BqLrjz4AqyYYdIeqF8YqUHLqjUj/zhFrZ9GYHX+gCKM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Caj7hqeHQtxaFom0WpLi+v9z1smcZusbh3vdb5DGXdS6zzsZQgFSIauPv26GXz5WpvWULT3RKPewqpy+d/+kxtu82zt8KbmFY0rayiMuOn2Rmq+r4I9nN2KOV+pX+MxOE0NGCsQLCOYaK5Xh+LMnMm1pozxs1VLQ+n5TPvKYZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJObhqCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJObhqCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019671F000FF;
	Tue, 13 Oct 2026 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932148;
	bh=Mgw6S7BFVDaugmxdNTM256SbmYf9a70BUAxB48lOJ/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJObhqColcPgEY2H8Th9G9LxhxIYltREgfuk9waruuPlbiJATIUCo4GeaGU6v+MXp
	 pRkM+M9/scGFGTN5gwMDQbFlL0j1+ME4mYCTJF+T/JofoFoi/n1TAgTsjvCE4gDYUn
	 4jID4Xvk48/om5aA1KSYaovwlYWvulz9y8SU/Ye++FNtmBZpddiHd/uaPAfGyBdQGz
	 +8DTVzLA9rWzE8aQ68GMIZNU8PRJUCTL+iPSe42WiSAdcvRSh9Z+SXjXTVT+bVUZB5
	 DFWE0AWXYo3Ar3wmIZDoI8iI7MSGcmFNihq840DI8bSthINFE5hIz/f3k5roWbzYb4
	 AaZ9ECWysAqAA==
Message-ID: <sashiko-outbox-170609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] dlm: Free dlm_ls in kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "David Teigland" <teigland@redhat.com>, "Alexander
 Aring" <aahringo@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Richard Weinberger" <richard@nod.at>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Felix Kuehling" <Felix.Kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261013223946.1836757-7-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:55:46 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dlm: sysfs UAF of ls_recoverd_task during lockspace teardown
- [High] dlm: module unload UAF in dlm_ls_release under DEBUG_KOBJECT_RELEA=
SE
--

commit 5dce188281954f951472555cf7284cda831b20a7
Author: Ian Rogers <irogers@google.com>

dlm: Free dlm_ls in kobject release callback

This commit adds a kobject release callback, dlm_ls_release(), to properly
free the dlm_ls structure when the last kobject reference is dropped. This
fixes a use-after-free issue when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index a9c98b4f378f3..1d226b27d8e61 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c

[ ... ]

> @@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops =3D {
>  	.show  =3D dlm_attr_show,
>  	.store =3D dlm_attr_store,
>  };
> =20
> +static void dlm_ls_release(struct kobject *kobj)
> +{
> +	struct dlm_ls *ls =3D container_of(kobj, struct dlm_ls, ls_kobj);
> +
> +	kfree(ls);
> +}

[Severity: High]
Can this callback trigger an instruction page fault if the module is unload=
ed?

Under CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, kobject release is delayed by 1-4
seconds. If the dlm module is unloaded during this window, this callback
will point to unmapped memory when the delayed work executes.

[ ... ]

> @@ -615,7 +623,6 @@ static int new_lockspace(const char *name, const char=
 *cluster,
>  	rhashtable_destroy(&ls->ls_rsbtbl);
>   out_lsfree:
>  	kobject_put(&ls->ls_kobj);
> -	kfree(ls);
>   out:
>  	module_put(THIS_MODULE);
>  	return error;

[Severity: High]
In the error path of new_lockspace(), we drop the kobject reference and then
immediately drop the module reference via module_put(). Doesn't this allow
the module to be unloaded while the delayed kobject release is still pendin=
g?

Additionally, could this sequence open a use-after-free race window?

Earlier in the error path of new_lockspace(), we call dlm_recoverd_stop():

out_recoverd:
        dlm_recoverd_stop(ls);
out_callback:
        ...
out_lsfree:
        kobject_put(&ls->ls_kobj);

The recovery task is stopped and freed in dlm_recoverd_stop(), but the sysfs
entries aren't removed until kobject_put() is called much later. A concurre=
nt
sysfs write to the control file could invoke dlm_ls_start() in fs/dlm/membe=
r.c
and wake up the freed ls->ls_recoverd_task.

[ ... ]

> @@ -759,7 +766,7 @@ static int release_lockspace(struct dlm_ls *ls, unsig=
ned int release_option)
> =20
>  	dlm_delete_debug_file(ls);
> =20
> -	kobject_put(&ls->ls_kobj);
> +	kobject_del(&ls->ls_kobj);
> =20
>  	xa_destroy(&ls->ls_recover_xa);
>  	kfree(ls->ls_recover_buf);

[Severity: High]
Is there a similar use-after-free risk involving the recovery thread here?

Looking at the context in release_lockspace(), we stop the recovery thread
earlier:

release_lockspace() {
    ...
    dlm_recoverd_stop(ls);
    ...
    clear_bit(LSFL_RUNNING, &ls->ls_flags);
    ...
    kobject_del(&ls->ls_kobj);
    ...
    module_put(THIS_MODULE);
}

Since the sysfs kobject isn't deleted until after the recovery thread is
stopped and its task_struct is freed, the sysfs entries remain active in the
interim. A concurrent sysfs write to the control file could invoke
dlm_ls_start() which calls wake_up_process(ls->ls_recoverd_task) on the fre=
ed
task_struct.

Also, module_put() is called at the end of release_lockspace() while the
kobject delayed release is pending, repeating the module unload race mentio=
ned
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D6
