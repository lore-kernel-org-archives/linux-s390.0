From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 22 Mar 2017 13:05:28 +0000
Subject: Re: [PATCH 1/3] s390: cpacf: query instructions use unique parameters for compatibility with KMA
Message-Id: <20170322130528.GD3808@osiris>
In-Reply-To: <4771642a-b5fa-6010-28ca-c7242d1017ae@de.ibm.com>
References: <4771642a-b5fa-6010-28ca-c7242d1017ae@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 20, 2017 at 12:45:35PM +0100, Christian Borntraeger wrote:
> On 03/09/2017 04:55 PM, Jason J. Herne wrote:
> > The new KMA instruction requires unique parameters. Update __cpacf_query to
> > generate a compatible assembler instruction.
> > 
> > Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> > Acked-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
> 
> approved for devel.
> 
> Martin, FYI. We probably need a topic branch for this as well as soon as we have clearance.
> 
> 
> > ---
> >  arch/s390/include/asm/cpacf.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> > index 2c680db..6dd0db7 100644
> > --- a/arch/s390/include/asm/cpacf.h
> > +++ b/arch/s390/include/asm/cpacf.h
> > @@ -125,8 +125,8 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
> > 
> >  	asm volatile(
> >  		"	spm 0\n" /* pckmo doesn't change the cc */
> > -		/* Parameter registers are ignored, but may not be 0 */
> > -		"0:	.insn	rrf,%[opc] << 16,2,2,2,0\n"
> > +		/* Parameter regs are ignored, but must be nonzero and unique */
> > +		"0:	.insn	rrf,%[opc] << 16,2,4,6,0\n"
> >  		"	brc	1,0b\n"	/* handle partial completion */

Why do we have this spm 0 initialization and the brc loop for partial
completion? None of the crypto query instructions return with cc=3 for
partial completion.

> >  		: "=m" (*mask)

This is also declared as write-only, still there is a memset of *mask
before it is passed to this inline assembly.

In addition the comment above this function is wrong.
... inline assemblies ;)

And yes, I know that nothing of this was introduced by Jason.
