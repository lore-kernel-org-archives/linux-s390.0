Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AD2770B;
	Sun, 23 Feb 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333272; cv=none; b=jD0cK8GHjZOIqaXjrViix7+I9MD7EnTUHlfjbV4TWKDqqvx+t5nwx3r0MbSbdpIiBQz/HfB/xdeq2vuxDwGdOSLhyD+xi4quIca+67Ttc+v7onWnfjMdtZj9KY3n4rCiy6RVVsFbfUpevTzdVAy/b2QAGshukaV5f1O9Htr35f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333272; c=relaxed/simple;
	bh=9iFdhdTQZ2gneruKLG7YkE93h9YE3aeXMlyNM4pD9u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIP0V28ztaYO0Pj+kdmGfGGgsK1xuJl5JcFehJrNXHyCyk9tOWV8NmXBbUiUUi0tWPJ3O1bUaOrlMXDHFyStDTBS5bU2269qSwuh6t+I+RzLar9YzMHG7sKBomMzAsxuHZ9nuOrMs55e/LbumMWognPb42q563CgT9FFACazUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhMQcmO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhMQcmO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009D7C4CEDD;
	Sun, 23 Feb 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740333271;
	bh=9iFdhdTQZ2gneruKLG7YkE93h9YE3aeXMlyNM4pD9u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhMQcmO5owvm412qh9aUibQCAE5R3H0Y3labMbi96L/jt2+CCd3WvH8UF16mZ5MQB
	 Op9z/uv4OxpBHVLnUkOdjvePsC4VrM+yzCROUe68AVgBUrv7w2DmJHs4xbHfzB8QpG
	 Ozv4nty8IY+SrpRbBFPQHCs0ru5G1hevXj0yQo/cLPvQgyoOxJf1iid9sarJrcIcRd
	 eCJ2zlHemard7aIoWHBWDMYtSOYnbGfGHmDHpa7KlLg3WtovNvwgZK8HmKTQRBnOID
	 k675DyqrTrGHvR6fyQY78uyW/dVn8TdfgorHiV6DURp3ebpe+dlJCScpuL1M0bgk3c
	 jWSaiEQEmv7uA==
Date: Sun, 23 Feb 2025 19:54:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Philipp Rudo <prudo@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z7tgvwRkV-GAtBL_@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
 <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
 <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
 <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
 <Z7dbxJNxlW2EA_aa@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dbxJNxlW2EA_aa@tuxmaker.boeblingen.de.ibm.com>

On Thu, Feb 20, 2025 at 05:43:48PM +0100, Alexander Gordeev wrote:
> On Thu, Feb 20, 2025 at 09:49:52AM +0800, Dave Young wrote:
> > On Wed, 19 Feb 2025 at 21:55, Alexander Graf <graf@amazon.com> wrote:
> > > >>> What architecture exactly does this KHO work fine?   Device Tree
> > > >>> should be ok on arm*, x86 and power*, but how about s390?
> > > >> KHO does not use device tree as the boot protocol, it uses FDT as a data
> > > >> structure and adds architecture specific bits to the boot structures to
> > > >> point to that data, very similar to how IMA_KEXEC works.
> > > >>
> > > >> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> > > >> reason why it wouldn't work on any architecture that supports kexec.
> > > > Well,  the problem is whether there is a way to  add dtb in the early
> > > > boot path,  for X86 it is added via setup_data,  if there is no such
> > > > way I'm not sure if it is doable especially for passing some info for
> > > > early boot use.  Then the KHO will be only for limited use cases.
> > >
> > >
> > > Every architecture has a platform specific way of passing data into the
> > > kernel so it can find its command line and initrd. S390x for example has
> > > struct parmarea. To enable s390x, you would remove some of its padding
> > > and replace it with a KHO base addr + size, so that the new kernel can
> > > find the KHO state tree.
> > 
> > Ok, thanks for the info,  I cced s390 people maybe they can provide inputs.
> 
> If I understand correctly, the parmarea would be used for passing the
> FDT address - which appears to be fine. However, s390 does not implement
> early_memremap()/early_memunmap(), which KHO needs.

KHO uses early_memremap()/early_memunmap() because it parses FDT before
phys_to_virt() is available on arm64 and x86. AFAIU on s390 phys_to_virt()
can be used at setup_arch() time, so it shouldn't be a problem to add
appropriate wrappers.
 
-- 
Sincerely yours,
Mike.
