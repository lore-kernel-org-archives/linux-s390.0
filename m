Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080B41D11E;
	Fri,  2 Oct 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936310; cv=none; b=uEdz33CZqD2F+8r0sgthffO2hbg1a9a3js/1Ny5/NAZ7JKcjwbiZZ5vYUftGKVm7TAuicF7/SF3P8PMzfsJAagVTr25Q1kOzI2XqHq4vQrEFF9k/54OzMvliL7h/qWfulF5OzLzh0cIR16g8MC6abYWic92BGKYd6K9Bku5WR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936310; c=relaxed/simple;
	bh=EFvCrRBIWF5b7VjJlzEl/8QN+53YJGJq2xeX3a/6Rg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5NTJDiQ5GT2JUzp7P4pb2uXz1j+SOzxFzdrmZX7kuY/dapnofrbP6609IZWRBBNsof363fsuzVrG7AsqHfLa3yAuLpvkT2rn+3WnfD6e68QzaL8IcoAeqXU2sm74NvsINpYJcwwzhAPdur15hR3Xup3cbqfTafkwky5WExG2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO0QF7Fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO0QF7Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678BC1F000FF;
	Fri,  2 Oct 2026 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936308;
	bh=EFvCrRBIWF5b7VjJlzEl/8QN+53YJGJq2xeX3a/6Rg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dO0QF7Fy9SVQ3Fa+3btBoie+pDM8Lk1+P79E8N59Q1N4IH9/niZ/8pXqQp02wWRIR
	 N76lMDD2MAON/2AcdCkav+7m03E7uXn8HvN7EMymSxBB167Fny+no+8iBoDnHQG2vX
	 FHO264uotXxe9vgawMJBX5THTKcXj3pDtbdSD+QW05kEP+XMADvBf5ngIP0JQR4yXf
	 jeZj/9IOUm/NrsSHNjBwCQaJfbiZ8ttVXj2WX4djoX9UzrvuCaQju70PQofstqfd2I
	 kSJ+ymDKob9aZKysEpcibgHoMz5AQ2XWO8DC4CPqMOyW2BqOnfd7JHx4MB9yXaJjU/
	 M651mDE9LyZyA==
Date: Fri, 2 Oct 2026 11:18:18 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, Gautam Gala <ggala@linux.ibm.com>, 
	Hariharan Mari <hari55@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, 
	Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault
 handler
Message-ID: <ar-EcynSFG0BfW1E@gremlin>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
 <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
 <e1569c6e-94df-4609-8d94-d6319b4171cf@app.fastmail.com>
 <ar5udQI9qDAtYrGi@gremlin>
 <20261001153005.314717-B-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001153005.314717-B-seiden@linux.ibm.com>

On Thu, Oct 01, 2026 at 05:30:05PM +0200, Steffen Eiden wrote:
> On Thu, Oct 01, 2026 at 03:36:26PM +0100, Lorenzo Stoakes (ARM) wrote:

> > Ah the s390 <-> kvm emulation stuff.
>
> no, its not emulation :)
> We use a hardware based acclearaion approach.

Sorry my apologies, I did know this but mr. brain didn't engage there :) rushing
through mails (and been sick these last few days)...

> > Or both conditions? One for the s390 guys.
> >
> so just the initialized test.

OK cool, so Arnd's suggestion as-is, then. LGTM!

--
Cheers, Lorenzo
