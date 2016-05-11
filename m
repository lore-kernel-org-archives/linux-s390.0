From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Wed, 11 May 2016 18:12:56 +0800
Message-ID: <573305A8.50406@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4119683.coHZhzaE6c@wuerfel> <57329320.1000500@huawei.com>
 <4876119.A8fbdncu9Z@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4876119.A8fbdncu9Z@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi, Arnd

On 2016/5/11 16:09, Arnd Bergmann wrote:
 > On Wednesday 11 May 2016 10:04:16 Zhangjian wrote:
 >>> I don't remember. It's probably not important whether we have the shift
 >>> in there, as long as it's independent of the actual kernel page size and
 >>> user space and kernel agree on the calling conventions.
 >> Well. I am ok with where to shift the pages size because we get the same
 >> result. I was just thinking if we should get rid of the name of mmap2 in our
 >> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
 >> if they do not know the implementations.
 >
 > That is a good point: If the implementation matches the mmap() behavior rather than
 > mmap2(), we should rename the macro by doing
 >
 > #undef __NR_mmap2
 > #define __NR_mmap 222
 >
 > in the uapi/asm/unistd.h file for ilp32 mode.
Do you mean define the following things in kernel:
```
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 1caadc2..3f79640 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -14,3 +14,9 @@
   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
   */
  #include <asm-generic/unistd.h>
+
+#ifdef __ILP32__
+#undef __NR_mmap2
+#define __NR_mmap 222
+#endif /* #ifdef __ILP32__ */
+
```
Then glibc could call mmap instead of mmap2.
I could not try it now. Because after change off_t to 64bit in glibc, stat
is fail. I may need to revert the stat relative patch.

 > Alternatively we can keep the
 > __NR_mmap2 definition but then we need to pass the pgoff (value shifted by
 > 12 bits) argument rather than the size in bytes.
It means that we could reuse the existing code of mmap2 in kernel and glibc.
But we need to shift twice when kernel is 64k page.
It seems that the first method is more clear. Suggestion?

Regards

Bamvor
 >
 >   Arnd
 >
