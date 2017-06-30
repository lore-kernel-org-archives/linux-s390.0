From: Andrei Vagin <avagin@virtuozzo.com>
Date: Fri, 30 Jun 2017 17:45:27 +0000
Subject: Re: [CRIU] [PATCH v2 12/17] criu/pie/parasite-vdso: Handle also systems without VVAR
Message-Id: <20170630174526.GB31550@outlook.office365.com>
In-Reply-To: <CAJwJo6YCvkCJ-GXeRtjd+METmEQyNcguTFVMsFJbhsmVQMfjcg@mail.gmail.com>
References: <CAJwJo6YCvkCJ-GXeRtjd+METmEQyNcguTFVMsFJbhsmVQMfjcg@mail.gmail.com>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 30, 2017 at 12:48:23PM +0300, Dmitry Safonov wrote:
> 2017-06-30 0:07 GMT+03:00 Adrian Reber <adrian@lisas.de>:
> > On Thu, Jun 29, 2017 at 09:24:40PM +0200, Michael Holzheu wrote:
> >> On s390 we don't use vvar. Therefore vvar_size in not been initialized
> >> and the value remains VVAR_BAD_SIZE.
> >>
> >> Fix the BUG() statement to also cover this case.
> >>
> >> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >> Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>
> >
> > I need this patch also on x86_64 to make criu work again so:
> >
> > Tested-by: Adrian Reber <areber@redhat.com>
> 
> Andrew, please, take care of it independently to the set.

Applied, thanks!

> 
> >
> >> ---
> >>  criu/pie/parasite-vdso.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/criu/pie/parasite-vdso.c b/criu/pie/parasite-vdso.c
> >> index 40b2695..ad178e9 100644
> >> --- a/criu/pie/parasite-vdso.c
> >> +++ b/criu/pie/parasite-vdso.c
> >> @@ -44,9 +44,11 @@ static int vdso_remap(char *who, unsigned long from, unsigned long to, size_t si
> >>  /* Park runtime vDSO in some safe place where it can be accessible from restorer */
> >>  int vdso_do_park(struct vdso_maps *rt, unsigned long park_at, unsigned long park_size)
> >>  {
> >> +     unsigned long vvar_size;
> >>       int ret;
> >>
> >> -     BUG_ON((rt->sym.vdso_size + rt->sym.vvar_size) < park_size);
> >> +     vvar_size = (rt->sym.vvar_size == VVAR_BAD_SIZE) ? 0 : rt->sym.vvar_size;
> >> +     BUG_ON((rt->sym.vdso_size + vvar_size) < park_size);
> >>
> >>       if (rt->vvar_start != VVAR_BAD_ADDR) {
> >>               if (rt->sym.vdso_before_vvar) {
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> CRIU mailing list
> >> CRIU@openvz.org
> >> https://lists.openvz.org/mailman/listinfo/criu
> > _______________________________________________
> > CRIU mailing list
> > CRIU@openvz.org
> > https://lists.openvz.org/mailman/listinfo/criu
> 
> 
> 
> -- 
>              Dmitry
