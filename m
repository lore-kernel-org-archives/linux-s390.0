From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
Date: Tue, 16 Apr 2019 18:08:57 +0100
Message-ID: <20190416170857.GC7342@fuggles.cambridge.arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190416161434.32691-6-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Greentime Hu <green.hu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 16, 2019 at 05:14:34PM +0100, Vincenzo Frascino wrote:
> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
> 
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
> 
> The extension has been used to verify the hrtimer_resoltion fix.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  tools/testing/selftests/vDSO/Makefile         |   2 +
>  .../selftests/vDSO/vdso_clock_getres.c        | 108 ++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

Assuming this will go via Shuah's tree.

Will
