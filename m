Return-Path: <heiko.carstens@de.ibm.com>
Date: Tue, 23 Oct 2012 08:55:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Build regressions/improvements in v3.7-rc2
Message-ID: <20121023065548.GA4164@osiris.de.ibm.com>
References: <alpine.DEB.2.00.1210222146440.12209@ayla.of.borg>
 <CAMuHMdVS-qz0BAHXFGD01+w1GxyQ2M7DpLnLRQKtdZSiDfYgHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVS-qz0BAHXFGD01+w1GxyQ2M7DpLnLRQKtdZSiDfYgHw@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 22, 2012 at 09:50:26PM +0200, Geert Uytterhoeven wrote:
> On Mon, Oct 22, 2012 at 9:47 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.7-rc2 to v3.7-rc1[3], the summaries are:
> >   - build errors: +4/-44
> 
>   + arch/s390/include/asm/kvm_para.h: error: redefinition of
> 'kvm_arch_para_features':  => 147:28, 147:99
>   + arch/s390/include/asm/kvm_para.h: error: redefinition of
> 'kvm_check_and_clear_guest_paused':  => 152:91, 152:20
> 
> s390-allmodconfig/s390-allyesconfig/s390-defconfig

Thanks Geert. We have already a build fix for this from David Howells
which is waiting to be merged upstream.
