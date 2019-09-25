From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
Date: Wed, 25 Sep 2019 07:17:02 -0500
Message-ID: <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-devicetree/>
List-Post: <mailto:devicetree@vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, devicetree <devicetree@vger.kernel.org>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, kasan-dev <kasan-dev@googlegroups.com>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Chris Healy <cphealy@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 25, 2019 at 7:12 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Wed, Sep 25, 2019 at 6:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I know it's rather late, but this patch broke the Etnaviv 3D graphics
> > in my i.MX6Q.
> >
> > When I try to use the 3D, it returns some errors and the dmesg log
> > shows some memory allocation errors too:
> > [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> > [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> > [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> > [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> > [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> > memory window
> > [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> > [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> > memory window
>
> This looks similar to what was reported at:
> https://bugs.freedesktop.org/show_bug.cgi?id=111789
>
> Does it help if you use the same suggestion and pass cma=256M in your
> kernel command line?

I tried cma=256M and noticed the cma dump at the beginning didn't
change.  Do we need to setup a reserved-memory node like
imx6ul-ccimx6ulsom.dtsi did?

adam
